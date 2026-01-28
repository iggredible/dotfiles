# Hotwire Review Rules

Curated rules for reviewing Turbo and Stimulus code, based on 37signals style guide.

## Turbo Morphing

1. **Enable morphing globally with scroll preservation**:
   ```ruby
   # In layout or application controller
   turbo_refreshes_with method: :morph, scroll: :preserve
   ```

2. **Listen for `turbo:morph-element` to restore state**: Restore client-side state after morphs.

3. **Mark persistent elements with `data-turbo-permanent`**: Prevents refresh of specific elements.

4. **Ensure unique element IDs**: Duplicate IDs break morphing.

5. **Use `refresh: :morph` on frames with `src`**: Eliminates visual flicker on lazy-loaded frames.

## Turbo Frames

6. **Structure forms in frames**: Prevents state loss during partial updates. Frame-based updates maintain form data.

7. **Use `turbo_stream.replace` for in-place updates**: Instead of full redirects:
   ```ruby
   turbo_stream.replace dom_id(@card), partial: "cards/card"
   ```

8. **Use `data-turbo-frame="_parent"`**: Target parent frames without hardcoding IDs.

9. **Use `loading: "lazy"` for deferred content**: Better initial page load performance.

## Turbo Streams

10. **Available stream actions**:
    ```ruby
    turbo_stream.append target, partial: "..."
    turbo_stream.prepend target, partial: "..."
    turbo_stream.replace target, partial: "..."
    turbo_stream.update target, partial: "..."  # Updates content, keeps element
    turbo_stream.remove target
    turbo_stream.before target, partial: "..."
    turbo_stream.after target, partial: "..."
    ```

11. **Always pass `partial:` and `locals:`**: For explicit template rendering.

12. **Use morphing for complex updates**: Preserves form focus and input state:
    ```ruby
    turbo_stream.replace dom_id(@card, :container),
      partial: "cards/container",
      method: :morph
    ```

## Stimulus Controllers

13. **Single responsibility**: Each controller should focus on one job.

14. **Configuration via Values API**: No hardcoded strings:
    ```javascript
    // Good
    static values = { url: String, delay: Number }
    this.urlValue

    // Avoid
    this.element.getAttribute("data-url")
    ```

15. **Values provide type safety**: Automatic type coercion.

16. **Use camelCase in JavaScript**: Maps to kebab-case in HTML:
    ```javascript
    static values = { autoSubmit: Boolean }
    // Maps to: data-controller-auto-submit-value
    ```

17. **Always implement `disconnect()` cleanup**: Remove timers, listeners, observers:
    ```javascript
    disconnect() {
      clearInterval(this.#timer)
      clearTimeout(this.#timeout)
      this.observer?.disconnect()
      this.element.removeEventListener("custom", this.handler)
    }
    ```

## Stimulus Actions

18. **Use `:self` filter**: Scope events to specific controller instances:
    ```html
    <div data-action="click:self->modal#close">
    ```

19. **Use targets over CSS selectors**:
    ```javascript
    // Good
    static targets = ["input", "output"]
    this.inputTarget

    // Avoid
    this.element.querySelector(".input")
    ```

## Controller Communication

20. **Dispatch events, don't call other controllers directly**:
    ```javascript
    // In dropdown controller
    this.dispatch("selected", { detail: { id: this.idValue } })

    // Listen in HTML
    <div data-action="dropdown:selected->form#updateField">
    ```

21. **Event-driven loose coupling**: Controllers communicate through events, not direct method calls.

## State Management

22. **Use localStorage for UI state**: Persist preferences like expanded panels:
    ```javascript
    connect() {
      this.expanded = localStorage.getItem(this.storageKey) === "true"
    }

    toggle() {
      this.expanded = !this.expanded
      localStorage.setItem(this.storageKey, this.expanded)
    }
    ```

23. **Restore state on `turbo:morph-element`**: Use `nextFrame()` to await morph completion.

## Timing Utilities

24. **Extract shared timing logic to modules**:
    ```javascript
    // app/javascript/helpers/timing_helpers.js
    export function throttle(fn, delay = 1000) {
      let timeoutId = null
      return (...args) => {
        if (!timeoutId) {
          fn(...args)
          timeoutId = setTimeout(() => timeoutId = null, delay)
        }
      }
    }

    export function debounce(fn, delay = 1000) {
      let timeoutId = null
      return (...args) => {
        clearTimeout(timeoutId)
        timeoutId = setTimeout(() => fn.apply(this, args), delay)
      }
    }
    ```

## File Organization

25. **Controllers in `app/javascript/controllers/`**: Descriptive filenames.

26. **Shared utilities in `app/javascript/helpers/`**: `timing_helpers.js`, `date_helpers.js`.

## Interaction Patterns

27. **Links over JavaScript buttons**: Filter chips as plain `<a>` tags enable native browser affordances:
    ```erb
    <%# Good - native link behavior %>
    <%= link_to "Active", cards_path(filter: :active) %>

    <%# Avoid - JS-powered button %>
    <button data-action="click->filter#apply">Active</button>
    ```

28. **POST for state toggles**: Use POST method, not GET.

29. **Lazy loading with IntersectionObserver**: Fetch content when elements become visible.

## Accessibility

30. **Apply `aria-hidden` during dialogs**: Hide background content.

31. **Use `aria-selected` for keyboard-navigable lists**.

32. **Include `.visually-hidden` for screen readers**.

33. **Proper focus management in dialogs**: Focus first element on open, restore on close.

34. **Set `aria-busy="true"` during async operations**.

## Performance

35. **Accept minor visual flashing**: As tradeoff for faster perceived performance.

36. **Prefer element-specific morph events**: Over global listeners.

37. **Use `requestAnimationFrame`**: For DOM-dependent timing.

## Broadcasting (Multi-Tenant)

38. **Scope broadcasts with account context**:
    ```ruby
    broadcast_to [Current.account, card]
    ```

## What to Avoid

39. **Avoid React/Vue**: Turbo + Stimulus with server-rendered HTML is preferred. SPAs add JavaScript maintenance burden.

40. **Avoid complex client-side state**: Let the server be the source of truth.

41. **Avoid hardcoded strings in controllers**: Use Values API for configuration.
