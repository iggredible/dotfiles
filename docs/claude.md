# Claude

Clean up `.claude` files (if needed):
```
rm -r ~/.claude
rm ~/.claude.json
```

Symlink the claude files:
```
ln -sf ~/Projects/dotfiles/.claude.json ~/.claude.json
ln -sf ~/Projects/dotfiles/.claude ~/
```

Notes:
- `.claude.json` has a list of MCP servers
- `.claude/` directory has custom slash commands

Install [claude code](https://docs.anthropic.com/en/docs/claude-code/setup)
```
npm install -g @anthropic-ai/claude-code
```

TODO:
-  subagents configs
