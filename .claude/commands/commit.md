---
description: Review changes and create a well-formatted commit message
---

# Git Status
!`git status --short`

# Current Branch
!`git branch --show-current`

# Staged Changes
!`git diff --staged --stat`

# Full Diff
!`git diff --staged`

Based on the changes above:

1. **Review All Changes**
   - Understand what was modified and why
   - Check for any debugging code or secrets
   - Verify changes are cohesive and belong together

2. **Generate Commit Message**
   Follow the **50/72 rule**:
   - **Summary line**: Maximum 50 characters
     - Use conventional commits format (feat:, fix:, docs:, refactor:, test:, chore:)
     - Use imperative mood ("Add feature" not "Added feature")
     - No period at the end
   
   - **Blank line**
   
   - **Body** (if needed): Wrap at 72 characters
     - Explain WHAT and WHY (not how)
     - Separate paragraphs with blank lines
     - Reference issue numbers if applicable

3. **Present Message**
   - Show the formatted commit message
   - Ask for approval before committing
   - Execute: `git commit -m "summary" -m "body"`

**Example Format:**
```
feat: add user authentication endpoint

Implement JWT-based authentication for the user login flow.
This allows users to securely access protected resources.

- Add /auth/login route
- Include token refresh logic
- Update user model with lastLogin field

Closes #123
```
