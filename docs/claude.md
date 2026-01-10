# Claude

Install [claude code](https://docs.anthropic.com/en/docs/claude-code/setup)

## Setup

Symlink the `.claude` directory to share settings, commands, and agents across all projects:

```bash
ln -s ~/Projects/dotfiles/.claude ~/.claude
```

This makes your Claude configuration the user-level default. Project-specific `.claude/settings.json` files will override these defaults when needed.

## Claude Code Customization

Custom commands and subagents for efficient development workflows. Feel free to add your own!

## Commands 

Type `/` in Claude Code to see all available commands:

- **`/test [target]`** - Run tests for specific files/modules or entire suite
- **`/review`** - Review staged changes for bugs, security, and quality
- **`/debug <issue>`** - Debug and fix errors or failing tests
- **`/commit`** - Generate well-formatted commit message following 50/72 rule

**Usage:**
```bash
> /test auth
> /review
> /debug "login endpoint returns 500"
> /commit
```

## Subagents 

Claude automatically uses these specialized agents based on context:

- **tester** - Runs and fixes tests after code changes
- **reviewer** - Reviews code quality and security
- **debugger** - Investigates errors and root causes

Explicit Usage:
```bash
> Use the tester subagent to fix failing tests
> Ask the reviewer subagent to check my recent changes
> Have the debugger subagent investigate this stack trace
```

Automatic Invocation:
```bash
> I updated the auth logic
# → reviewer automatically activates

> [Claude makes code changes]
# → tester proactively runs tests
```

---

**Tip:** Subagents work in isolated contexts, keeping your main conversation clean. Commands are quick shortcuts for common tasks.

