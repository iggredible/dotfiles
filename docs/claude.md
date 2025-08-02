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

Install [claude code](https://docs.anthropic.com/en/docs/claude-code/setup)
```
npm install -g @anthropic-ai/claude-code
```

TODO:
-  MCP servers configs
-  subagents configs
