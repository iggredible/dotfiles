---
name: rename.date
description: Rename the current session with today's date prepended (YYYY_MM_DD_<name>)
---

# Date Rename

Rename the current session with today's date prepended.

## Instructions

When the user runs `/rename.date <name>`:

1. Get today's date and format it as `YYYY_MM_DD` (e.g., `2026_04_02`)
2. Prepend it to the user's argument: `YYYY_MM_DD_<name>`
3. Output the `/rename` command for the user to copy and run, since `/rename` is a built-in CLI command that cannot be invoked programmatically

For example, if today is 2026-04-02 and the user runs `/rename.date my-session`, output:

```
/rename 2026_04_02_my-session
```

If no argument is provided, ask the user for a session name.
