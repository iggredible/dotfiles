# Test-Driven Development

## Philosophy

**Core principle**: Tests should verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't.

**Good tests** are integration-style: they exercise real code paths through public APIs. They describe _what_ the system does, not _how_ it does it. A good test reads like a specification - "user can checkout with valid cart" tells you exactly what capability exists. These tests survive refactors because they don't care about internal structure.

**Bad tests** are coupled to implementation. They mock internal collaborators, test private methods, or verify through external means (like querying a database directly instead of using the interface). The warning sign: your test breaks when you refactor, but behavior hasn't changed. If you rename an internal function and tests fail, those tests were testing implementation, not behavior.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

## Anti-Pattern: Horizontal Slices

**DO NOT write all tests first, then all implementation.** This is "horizontal slicing" - treating RED as "write all tests" and GREEN as "write all code."

This produces **crap tests**:

- Tests written in bulk test _imagined_ behavior, not _actual_ behavior
- You end up testing the _shape_ of things (data structures, function signatures) rather than user-facing behavior
- Tests become insensitive to real changes - they pass when behavior breaks, fail when behavior is fine
- You outrun your headlights, committing to test structure before understanding the implementation

**LLM-specific failure modes to guard against:**

- **NEVER rewrite a failing test to make it pass.** If a test fails, fix the implementation, not the test. When context runs low, the temptation is to "fix" the test — this defeats the entire purpose of TDD.
- **NEVER verify mocks instead of real code paths.** Tests must exercise actual behavior.
- **Bad tests are debt, not just review problems.** Every test created must be maintained forever. Tests not tied to actual behavior become expensive liabilities.

**Correct approach**: Vertical slices via tracer bullets. One test → one implementation → repeat. Each test responds to what you learned from the previous cycle. Because you just wrote the code, you know exactly what behavior matters and how to verify it.

```
WRONG (horizontal):
  RED:   test1, test2, test3, test4, test5
  GREEN: impl1, impl2, impl3, impl4, impl5

RIGHT (vertical):
  RED→GREEN: test1→impl1
  RED→GREEN: test2→impl2
  RED→GREEN: test3→impl3
  ...
```

## Workflow

### 1. Planning

Before writing any code, answer these questions with the user:

1. **What interface changes are needed?** What functions, methods, or APIs are being added or modified?
2. **Which behaviors matter most?** You can't test everything. Prioritize critical paths and complex logic over edge cases.
3. **Can we design for deep modules?** (From "A Philosophy of Software Design") A deep module has a small interface but handles complex logic internally — fewer methods, simpler parameters, more hidden complexity. This makes testing simpler and the API cleaner. Avoid shallow modules: large interfaces with many methods that just pass through to other components. Ask: Can I reduce methods? Simplify parameters? Hide more complexity inside?
4. **Can we design for testability?** Functions should accept dependencies rather than create them. They should return results instead of producing side effects. See [interface-design.md](interface-design.md).

- [ ] List the behaviors to test (not implementation steps)
- [ ] Get user approval on the plan

**The better the user's answers to these questions, the higher the code quality.**

### 2. Tracer Bullet

Write ONE test that confirms ONE thing about the system:

```
RED:   Write test for first behavior → test fails
GREEN: Write minimal code to pass → test passes
```

This is your tracer bullet - proves the path works end-to-end.

### 3. Incremental Loop

For each remaining behavior:

```
RED:   Write next test → fails
GREEN: Minimal code to pass → passes
```

Rules:

- One test at a time
- Only enough code to pass current test
- Don't anticipate future tests
- Keep tests focused on observable behavior

### 4. Refactor

After all tests pass, look for refactor candidates:

- [ ] **Duplication** → Extract function/class
- [ ] **Long methods** → Break into private helpers (keep tests on public interface)
- [ ] **Shallow modules** → Combine or deepen
- [ ] **Feature envy** → Move logic to where data lives
- [ ] **Primitive obsession** → Introduce value objects
- [ ] **Existing code** the new code reveals as problematic
- [ ] Run tests after each refactor step

**Never refactor while RED.** Get to GREEN first.

## Checklist Per Cycle

```
[ ] Test describes behavior, not implementation
[ ] Test uses public interface only
[ ] Test would survive internal refactor
[ ] Code is minimal for this test
[ ] No speculative features added
```
