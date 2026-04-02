---
name: Rails Code Reviewer
description: Interactive Rails code review based on thoughtbot, rubocop, and 37signals style guides
---

# Rails Code Reviewer

An interactive Rails code review skill based on thoughtbot, rubocop, and 37signals (Basecamp/HEY) style guides.

## Sources

Rules are merged from:
- [Thoughtbot guides](https://github.com/thoughtbot/guides/tree/main/rails) - Community best practices
- [37signals unofficial styleguide](https://github.com/marckohlbrugge/unofficial-37signals-coding-style-guide) - Patterns from Basecamp, HEY, and Campfire (DHH's team)
- [rubocop rails styleguide](https://raw.githubusercontent.com/rubocop/rails-style-guide/refs/heads/master/README.adoc) - Static analysis rules

## References

Detailed rules are organized in the `references/` directory:

- **references/models.md** (~46 rules) - ActiveRecord, concerns, state management
- **references/controllers.md** (~35 rules) - Thin controllers, concerns, CRUD
- **references/migrations.md** (~48 rules) - Schema, state tables, indexes
- **references/routing.md** (~38 rules) - CRUD-based routing, nesting
- **references/views.md** (~42 rules) - Partials, caching, Turbo streams
- **references/testing.md** (~45 rules) - Minitest/RSpec, fixtures/factories
- **references/hotwire.md** (~41 rules) - Turbo, Stimulus, morphing

**Read the relevant reference files before reviewing code in that category.**

## Review Workflow

### Step 1: Determine Scope and Start Reviewing

**Default behavior**: Review current branch changes (`git diff`) across all relevant categories. Auto-detect which reference files to load based on changed file paths:
- `app/models/` → load `references/models.md`
- `app/controllers/` → load `references/controllers.md`
- `db/migrate/` → load `references/migrations.md`
- `config/routes.rb` → load `references/routing.md`
- `app/views/` → load `references/views.md`
- `test/` or `spec/` → load `references/testing.md`
- `app/javascript/controllers/` → load `references/hotwire.md`

If the user provides arguments (e.g., `/rails-reviewer app/models/`), review those specific paths instead.

Only ask the user for clarification if:
- No changes are found on the current branch
- The scope is ambiguous

### Step 2: Review in Chunks

Present findings in digestible chunks by priority:

1. **High priority** - Security, data integrity, performance
2. **Style violations** - Naming, organization, conventions
3. **Pattern opportunities** - 37signals conventions worth considering
4. **Suggestions** - Improvements, not necessarily issues

After each chunk, ask:
> Want me to explain any of these, show fixes, or move to the next category?

### Step 3: Handle Feedback

Allow the user to:
- **Dismiss findings**: "Ignore that one" or "That's intentional"
- **Request depth**: "Tell me more about state records vs booleans"
- **Get fixes**: "Show me how to convert this to a concern"
- **Adjust focus**: "Actually, focus on Hotwire patterns"

### Step 4: Provide Summary

```
## Review Summary

### Must Fix (High Priority)
- [ ] Issue 1: description (file:line)

### Should Fix (Medium Priority)
- [ ] Issue 2: description (file:line)

### Consider (Pattern Opportunities)
- [ ] Suggestion: description

### Stats
- Files reviewed: X
- Issues found: Y
- Categories covered: Z
```

## Review Principles

1. **Adapt to the codebase**: Detect existing patterns first. If the project uses RSpec, don't suggest Minitest. If it uses service objects pervasively, note the 37signals alternative once in the summary but don't flag every instance. Don't fight established conventions.
2. **Be specific**: Reference exact files and line numbers.
3. **Explain why**: Don't just cite rules — explain the reasoning.
4. **Suggest fixes**: Provide concrete code examples.
5. **Prioritize by severity**: Security > Data Integrity > Performance > Convention > Style suggestion. Reference rules are guidelines — naming conventions are low priority, security issues are high priority, 37signals patterns are suggestions.
6. **Be pragmatic**: Not every rule applies to every codebase.
7. **Note trade-offs**: 37signals patterns have trade-offs — mention them.
8. **Handle large diffs**: For diffs with >20 files, prioritize models and migrations first, then controllers, then views. Mention skipped files in the summary.

## Example Session

```
User: /rails-reviewer

Claude: [Reads git diff, detects model + hotwire changes, loads references/models.md and references/hotwire.md]

**Model Review: app/models/card.rb** — 3 findings

1. **Boolean column could be a state record** (Line 15) — Consider a `Closure` model instead.
2. **Extract to concern** (Lines 20-45) — Closeable behavior could be a concern.
3. **Missing `touch: true`** (Line 8) — For cache invalidation.

Want me to explain any of these, show fixes, or continue to Hotwire?
```
