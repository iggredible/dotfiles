#!/usr/bin/env python3
"""
extract.py — render a Claude Code session (JSONL) as human-readable markdown.

    python3 extract.py --latest [--dir DIR]       # current session in this project
    python3 extract.py FILE.jsonl [--dir DIR]     # a specific transcript
    python3 extract.py --stdin [--dir DIR]        # SessionEnd hook mode
    ... --out PATH                                # exact file, overrides --dir

Output: <DIR>/YYYY_MM_DD-<slug>.md
DIR comes from `metadata.output-dir` in SKILL.md beside this script (default
chats). --dir overrides it for one run. Relative dirs resolve against the project.

No dependencies. Prompts are the spine; tool calls collapse to one line each;
thinking and raw tool output are dropped. Unknown record types are skipped, so
transcript-format changes degrade gracefully instead of crashing.
"""
import argparse, json, os, re, sys
from datetime import datetime
from pathlib import Path

MAX_CMD = 90          # truncate long bash commands in the one-liner
MAX_INDEX = 100       # prompt length in the index


# ---------- locating the transcript ----------------------------------------

def config_dir() -> Path:
    """$CLAUDE_CONFIG_DIR if set, else ~/.claude (works through a symlink too)."""
    return Path(os.environ.get("CLAUDE_CONFIG_DIR") or Path.home() / ".claude").expanduser()

def project_dir(cwd: str) -> Path:
    """<config_dir>/projects/<cwd with non-alphanumerics replaced by '-'>"""
    encoded = re.sub(r"[^A-Za-z0-9]", "-", cwd)
    return config_dir() / "projects" / encoded

def latest_transcript(cwd: str) -> Path:
    # The transcript lives under the directory Claude Code was *launched* in,
    # which may be an ancestor of the current cwd. Check cwd, then each parent.
    p = Path(cwd).resolve()
    for candidate in [p, *p.parents]:
        d = project_dir(str(candidate))
        files = sorted(d.glob("*.jsonl"), key=lambda f: f.stat().st_mtime, reverse=True)
        if files:
            return files[0]
    # Last resort: whichever transcript anywhere was written to most recently.
    allf = sorted(config_dir().glob("projects/*/*.jsonl"),
                  key=lambda f: f.stat().st_mtime, reverse=True)
    if not allf:
        sys.exit("no transcripts found — send at least one message before running /extract")
    print(f"note: no transcript folder for {cwd} or its parents; using newest: "
          f"{allf[0].parent.name}/{allf[0].name}", file=sys.stderr)
    return allf[0]


# ---------- parsing --------------------------------------------------------

def load(path: Path):
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            yield json.loads(line)
        except json.JSONDecodeError:
            continue

def blocks(msg):
    """Normalise message.content to a list of blocks."""
    c = (msg or {}).get("content")
    if isinstance(c, str):
        return [{"type": "text", "text": c}]
    return c if isinstance(c, list) else []

def strip_command_tags(text: str) -> str:
    # slash commands appear as <command-name>/foo</command-name> wrappers
    text = re.sub(r"<command-[a-z-]+>.*?</command-[a-z-]+>", "", text, flags=re.S)
    text = re.sub(r"<local-command-stdout>.*?</local-command-stdout>", "", text, flags=re.S)
    return text.strip()


# ---------- tool call one-liners -------------------------------------------

def one_line(s: str, n: int) -> str:
    s = " ".join(str(s).split())
    return s if len(s) <= n else s[: n - 1] + "…"

def describe_tool(name: str, inp: dict) -> str:
    inp = inp or {}
    p = inp.get("file_path") or inp.get("path") or inp.get("notebook_path") or ""
    if name in ("Read", "View"):
        return f"`Read {p}`"
    if name in ("Edit", "MultiEdit", "NotebookEdit"):
        return f"`Edit {p}`"
    if name == "Write":
        return f"`Write {p}`"
    if name == "Bash":
        cmd = one_line(inp.get("command", ""), MAX_CMD)
        desc = inp.get("description")
        return f"`Bash: {cmd}`" + (f" — {desc}" if desc else "")
    if name == "Grep":
        return f"`Grep \"{inp.get('pattern','')}\"" + (f" in {p}`" if p else "`")
    if name == "Glob":
        return f"`Glob {inp.get('pattern','')}`"
    if name == "WebSearch":
        return f"`WebSearch: {one_line(inp.get('query',''), 80)}`"
    if name == "WebFetch":
        return f"`WebFetch: {one_line(inp.get('url',''), 80)}`"
    if name in ("Task", "Agent"):
        return f"`Task: {one_line(inp.get('description') or inp.get('prompt',''), 80)}`"
    if name == "TodoWrite":
        return "`TodoWrite` — updated task list"
    # generic fallback: first string-valued input
    for v in inp.values():
        if isinstance(v, str) and v.strip():
            return f"`{name}: {one_line(v, 80)}`"
    return f"`{name}`"

def describe_result(res: dict) -> str:
    """Short outcome for a tool_result block."""
    if not res:
        return ""
    content = res.get("content")
    if isinstance(content, list):
        content = "\n".join(b.get("text", "") for b in content if isinstance(b, dict))
    content = content or ""
    if res.get("is_error"):
        first = one_line(content.splitlines()[0] if content.strip() else "error", 80)
        return f" → **error**: {first}"
    lines = content.count("\n") + 1 if content.strip() else 0
    return f" → {lines} lines" if lines > 3 else ""

COMMIT_RE = re.compile(r"git\s+commit\b.*?-m\s+(?:'([^']*)'|\"([^\"]*)\"|(\S+))", re.S)

def commit_message(cmd: str):
    m = COMMIT_RE.search(cmd or "")
    return (m.group(1) or m.group(2) or m.group(3)) if m else None


# ---------- building the document ------------------------------------------

def render(path: Path) -> tuple[str, dict]:
    records = list(load(path))
    meta = {"title": None, "cwd": None, "branch": None, "model": None,
            "first_ts": None, "last_ts": None, "session": path.stem}
    exchanges = []         # [{prompt, ts, items:[...]}]
    results = {}           # tool_use_id -> result block
    files_touched = []

    # pass 1: index tool results by id
    for r in records:
        if r.get("type") == "user":
            for b in blocks(r.get("message")):
                if b.get("type") == "tool_result":
                    results[b.get("tool_use_id")] = b

    # pass 2: walk the conversation
    for r in records:
        t = r.get("type")
        ts = r.get("timestamp")
        if ts:
            meta["first_ts"] = meta["first_ts"] or ts
            meta["last_ts"] = ts
        meta["cwd"] = meta["cwd"] or r.get("cwd")
        meta["branch"] = meta["branch"] or r.get("gitBranch")

        if t == "custom-title":
            meta["title"] = r.get("customTitle") or meta["title"]
            continue
        if t == "summary" and not meta["title"]:
            meta["title"] = r.get("summary")
            continue
        if t == "user":
            if r.get("isMeta"):
                continue
            bl = blocks(r.get("message"))
            if any(b.get("type") == "tool_result" for b in bl):
                continue   # tool results are not prompts
            text = strip_command_tags("\n".join(b.get("text", "") for b in bl if b.get("type") == "text"))
            if not text:
                continue
            exchanges.append({"prompt": text, "ts": ts, "items": []})
            continue
        if t == "assistant":
            if not exchanges:
                exchanges.append({"prompt": "(session start)", "ts": ts, "items": []})
            msg = r.get("message") or {}
            meta["model"] = meta["model"] or msg.get("model")
            cur = exchanges[-1]["items"]
            for b in blocks(msg):
                bt = b.get("type")
                if bt == "text" and b.get("text", "").strip():
                    cur.append(("text", b["text"].strip()))
                elif bt == "tool_use":
                    name, inp = b.get("name", "?"), b.get("input") or {}
                    line = describe_tool(name, inp) + describe_result(results.get(b.get("id")))
                    cur.append(("tool", line))
                    p = inp.get("file_path") or inp.get("path")
                    if name in ("Edit", "MultiEdit", "Write", "NotebookEdit") and p:
                        files_touched.append(p)
                    if name == "Bash":
                        cm = commit_message(inp.get("command", ""))
                        if cm:
                            cur.append(("commit", cm))
                # thinking / redacted_thinking: dropped on purpose

    # ---- emit
    date = (meta["first_ts"] or datetime.now().isoformat())[:10]
    title = meta["title"] or one_line(exchanges[0]["prompt"], 60) if exchanges else "Empty session"
    out = []
    out.append("---")
    out.append(f"date: {date}")
    out.append(f"project: {os.path.basename(meta['cwd'] or '') or 'unknown'}")
    out.append(f"branch: {meta['branch'] or ''}")
    out.append(f"model: {meta['model'] or ''}")
    out.append(f"session: {meta['session']}")
    out.append(f"prompts: {len(exchanges)}")
    out.append("---\n")
    out.append(f"# {title}\n")
    if meta["first_ts"] and meta["last_ts"]:
        out.append(f"_{meta['first_ts'][:16].replace('T',' ')} → {meta['last_ts'][:16].replace('T',' ')}_\n")

    out.append("## Prompts\n")
    for i, e in enumerate(exchanges, 1):
        out.append(f"{i}. [{one_line(e['prompt'], MAX_INDEX)}](#prompt-{i})")
    out.append("")

    for i, e in enumerate(exchanges, 1):
        out.append(f"## Prompt {i} <a id=\"prompt-{i}\"></a>\n")
        out.append("> " + e["prompt"].replace("\n", "\n> ") + "\n")
        pending_tools = []
        def flush():
            nonlocal pending_tools
            if pending_tools:
                out.extend(f"- {l}" for l in pending_tools)
                out.append("")
                pending_tools = []
        for kind, val in e["items"]:
            if kind == "tool":
                pending_tools.append(val)
            elif kind == "commit":
                pending_tools.append(f"**Commit:** {val}")
            else:
                flush()
                out.append(val + "\n")
        flush()

    if files_touched:
        out.append("## Files touched\n")
        out.extend(f"- `{p}`" for p in dict.fromkeys(files_touched))   # dedupe, keep order
        out.append("")
    return "\n".join(out), {**meta, "date": date, "title": title, "n": len(exchanges)}

def skill_settings() -> dict:
    """
    Read user settings from the `metadata:` block of SKILL.md beside this script.
    Minimal YAML: handles `key: value` at top level and one level of indent under
    `metadata:`. No dependencies. Missing file or block -> {}.
    """
    md = Path(__file__).resolve().parent / "SKILL.md"
    try:
        text = md.read_text(encoding="utf-8")
    except OSError:
        return {}
    m = re.match(r"\s*---\n(.*?)\n---", text, re.S)
    if not m:
        return {}
    settings, in_meta = {}, False
    for line in m.group(1).splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        indented = line[:1] in (" ", "\t")
        key, _, val = line.strip().partition(":")
        val = val.strip().strip("'\"")
        if not indented:
            in_meta = (key == "metadata" and not val)
            continue
        if in_meta and key:
            settings[key] = val
    return settings

def configured_dir() -> str:
    return skill_settings().get("output-dir") or "chats"

def slug(s: str) -> str:
    s = re.sub(r"[^a-z0-9]+", "-", s.lower()).strip("-")
    return "-".join(s.split("-")[:5]) or "session"


# ---------- entrypoint -----------------------------------------------------

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("file", nargs="?")
    ap.add_argument("--latest", action="store_true", help="newest transcript for $PWD")
    ap.add_argument("--stdin", action="store_true", help="read hook JSON from stdin")
    ap.add_argument("--out", help="exact output file; overrides --dir")
    ap.add_argument("--dir", default=None,
                    help="output directory. Overrides metadata.output-dir in SKILL.md. "
                         "Relative to the project, or absolute / ~-prefixed.")
    ap.add_argument("--cwd", default=os.getcwd())
    a = ap.parse_args()

    cwd = a.cwd
    if a.stdin:
        hook = json.load(sys.stdin)
        path = Path(hook["transcript_path"])
        cwd = hook.get("cwd", cwd)
    elif a.latest:
        path = latest_transcript(cwd)
    elif a.file:
        path = Path(a.file).expanduser()
    else:
        ap.error("give a FILE, --latest, or --stdin")

    md, meta = render(path)
    if meta["n"] == 0:
        return   # nothing worth writing (e.g. session opened and closed)
    if a.out and a.out.strip():
        out = Path(a.out).expanduser()
    else:
        d = Path(a.dir or configured_dir()).expanduser()
        if not d.is_absolute():
            d = Path(cwd) / d
        out = d / f"{meta['date'].replace('-', '_')}-{slug(meta['title'])}.md"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(md, encoding="utf-8")
    print(f"{out}  ({meta['n']} prompts)")

if __name__ == "__main__":
    main()
