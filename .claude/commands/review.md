---
description: Review staged changes for bugs, security issues, and code quality
---

# Git Status
!`git status --short`

# Staged Changes
!`git diff --staged --stat`

Perform a thorough code review of the staged changes above:

1. **Security Check**
   - SQL injection risks
   - XSS vulnerabilities
   - Exposed credentials or secrets
   - Authentication/authorization issues

2. **Code Quality**
   - Logic errors and edge cases
   - Performance concerns
   - Code clarity and maintainability
   - Adherence to project conventions

3. **Testing**
   - Are tests included/updated?
   - Is test coverage adequate?
   - Are edge cases tested?

4. **Documentation**
   - Are complex sections commented?
   - Is public API documented?

Provide actionable, prioritized feedback.
