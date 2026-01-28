# Rails Code Reviewer

An interactive Rails code review skill based on thoughtbot, rubocop, and 37signals (Basecamp/HEY) style guides.

## Description

This skill provides comprehensive Rails code review with curated rules from industry best practices, including patterns from 37signals. It's designed to be interactive—asking for your input and feedback throughout the review process.

## Sources

Rules are merged from:
- [Thoughtbot guides](https://github.com/thoughtbot/guides/tree/main/rails) - Community best practices
- [37signals unofficial styleguide](https://github.com/marckohlbrugge/unofficial-37signals-coding-style-guide) - Patterns from Basecamp, HEY, and Campfire (DHH's team)
- [rubocop rails styleguide](https://raw.githubusercontent.com/rubocop/rails-style-guide/refs/heads/master/README.adoc ) - Static analysis rules

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

## Interactive Review Workflow

When invoked, follow this workflow:

### Step 1: Determine Scope

Ask the user what they want reviewed:

1. **Current PR/branch changes** - Review uncommitted or branch changes
2. **Specific files** - User provides file paths
3. **A directory** - Review all Rails files in a directory
4. **Recent commits** - Review changes in recent commits

Example prompt:
> What would you like me to review?
> - Current branch changes (git diff)
> - Specific files (provide paths)
> - A directory (e.g., app/models/)
> - Something else?

### Step 2: Identify Focus Areas

Ask which aspects to focus on:

1. **Models** - Concerns, state management, validations, queries
2. **Controllers** - Thin controllers, concerns, responses
3. **Migrations** - Schema safety, state tables, indexes
4. **Routing** - CRUD-based, verb-to-noun, nesting
5. **Views** - Partials, caching, Turbo streams
6. **Testing** - Minitest/RSpec, fixtures/factories
7. **Hotwire** - Turbo, Stimulus, morphing
8. **All** - Comprehensive review

Example prompt:
> Which areas should I focus on?
> - Models (concerns, state records, queries)
> - Controllers (thin controllers, CRUD)
> - Hotwire (Turbo, Stimulus)
> - All areas
> - Let me know your priorities

### Step 3: Load Relevant Rules

Based on user selection, **read the appropriate reference files**:

- For models: Read `references/models.md`
- For controllers: Read `references/controllers.md`
- For migrations: Read `references/migrations.md`
- For routing: Read `references/routing.md`
- For views: Read `references/views.md`
- For testing: Read `references/testing.md`
- For hotwire: Read `references/hotwire.md`
- For all: Read all reference files as needed

### Step 4: Review in Chunks

Don't dump all findings at once. Present findings in digestible chunks:

1. **High priority issues** - Security, data integrity, performance
2. **Style violations** - Naming, organization, conventions
3. **37signals patterns** - Opportunities to apply 37signals conventions
4. **Suggestions** - Improvements, not necessarily issues

After each chunk, ask:
> I found [N] issues in this category. Want me to:
> - Explain any of these in detail?
> - Show suggested fixes?
> - Move to the next category?
> - Skip this category?

### Step 5: Handle Feedback

Allow the user to:

- **Dismiss findings**: "Ignore that one" or "That's intentional"
- **Request depth**: "Tell me more about state records vs booleans"
- **Get fixes**: "Show me how to convert this to a concern"
- **Adjust focus**: "Actually, focus on Hotwire patterns"

### Step 6: Provide Summary

At the end, provide an actionable summary:

```
## Review Summary

### Must Fix (High Priority)
- [ ] Issue 1: description (file:line)
- [ ] Issue 2: description (file:line)

### Should Fix (Medium Priority)
- [ ] Issue 3: description (file:line)

### Consider (37signals Patterns)
- [ ] Convert boolean to state record for audit trail
- [ ] Extract to concern for reusability

### Stats
- Files reviewed: X
- Issues found: Y
- Categories covered: Z
```

## Key 37signals Patterns

When reviewing, look for opportunities to apply these 37signals patterns:

### Models
- **State as records, not booleans** - `Closure`, `Pin` models instead of `closed`, `pinned` columns
- **Heavy use of concerns** - 50-150 line focused concerns like `Closeable`, `Watchable`
- **Current for context** - `Current.user`, `Current.account` via `ActiveSupport::CurrentAttributes`
- **Let it crash** - Bang methods (`create!`, `save!`) over silent failures
- **Avoid service objects** - Rich models and POROs instead

### Controllers
- **Everything is CRUD** - Convert `post :close` to `resource :closure`
- **Thin orchestrators** - Controllers call model methods, no business logic
- **Unified API/web** - Single controller with `respond_to` blocks

### Database
- **UUIDs over integers** - Prevents enumeration, supports distribution
- **Hard deletes** - Simpler queries, use audit tables for history

### Views
- **Partials over ViewComponent** - Simpler, less overhead
- **Explicit locals** - No implicit instance variable dependencies
- **DOM IDs via `dom_id()`** - Consistent naming for Turbo

### Hotwire
- **Turbo morphing** - Enable globally with scroll preservation
- **Stimulus Values API** - Type-safe configuration, no hardcoded strings
- **Links over JS buttons** - Native browser affordances

## Review Principles

1. **Be specific**: Reference exact files and line numbers
2. **Explain why**: Don't just cite rules; explain the reasoning
3. **Suggest fixes**: Provide concrete code examples
4. **Prioritize**: Security > Data Integrity > Performance > Style
5. **Be pragmatic**: Not every rule applies to every codebase
6. **Respect context**: Ask about existing patterns before suggesting changes
7. **Note trade-offs**: 37signals patterns have trade-offs—mention them

## What 37signals Avoids

When reviewing, note if code uses patterns 37signals explicitly avoids:
- **Devise** - They use ~150 lines of custom passwordless auth
- **Pundit/CanCanCan** - They use simple `editable_by?(user)` predicates
- **Service objects** - They use rich models and POROs
- **Form objects** - They use strong params and model validations
- **ViewComponent** - They use ERB partials
- **GraphQL** - They use REST with Turbo
- **RSpec** - They use Minitest
- **FactoryBot** - They use fixtures
- **Tailwind** - They use native CSS with cascade layers

These aren't "wrong"—just different philosophies. Note them without being prescriptive.

## Example Session

```
User: /rails-reviewer

Claude: I'll help review your Rails code. What would you like me to review?
- Current branch changes
- Specific files
- A directory

User: Current branch changes, focus on models and hotwire

Claude: I'll review the changes on your current branch, focusing on models and Hotwire patterns.
[Reads references/models.md and references/hotwire.md, then reads git diff]

Let me start with the model changes...

**Model Review: app/models/card.rb**

I found 3 opportunities for improvement:

1. **Boolean column could be a state record** (Line 15)
   You have `closed: boolean`. Consider a `Closure` model instead to track WHO closed it and WHEN.

   ```ruby
   # Current
   scope :closed, -> { where(closed: true) }

   # 37signals pattern
   has_one :closure, dependent: :destroy
   scope :closed, -> { joins(:closure) }
   scope :open, -> { where.missing(:closure) }
   ```

2. **Extract to concern** (Lines 20-45)
   The closeable behavior (scope, method, callback) could be a `Closeable` concern.

3. **Missing `touch: true`** (Line 8)
   `belongs_to :board` should have `touch: true` for cache invalidation.

Should I explain any of these, show the full concern extraction, or continue to Hotwire?
```
