---
name: extract
description: Render this session to a readable markdown transcript (deterministic, no LLM)
argument-hint: [output path]
allowed-tools: Bash(python3:*)
disable-model-invocation: true
metadata:
  # Where transcripts are written. Relative to the project, or absolute / ~ path.
  # Also used by the SessionEnd hook. Filename is YYYY_MM_DD-<slug>.md
  output-dir: chatz
---

!`python3 ~/.claude/skills/extract/extract.py --latest --out "$ARGUMENTS"`

The line above is the path the transcript was written to. Repeat it to the
user in one short sentence and stop. Do not open, summarize, or modify the file.
