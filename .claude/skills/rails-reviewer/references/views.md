# View Review Rules

Curated rules for reviewing Rails views and templates, merged from thoughtbot, rubocop, and 37signals style guides.

## Template Organization

1. **Keep views simple**: Views should render data, not compute it. Move logic to:
   - Helpers for reusable formatting
   - Model methods for display logic
   - Partials for reused elements

2. **Limit instance variables**: Views should ideally use only one instance variable.

3. **Explicit locals in partials (37signals)**: Pass data explicitly, avoid implicit instance variable dependencies:
   ```erb
   <%# Good - explicit dependencies %>
   <%= render 'cards/preview', card: card, draggable: true %>

   <%# Avoid - relies on instance variable %>
   <%= render 'cards/preview' %>
   ```

4. **Use layouts for shared structure**: Don't repeat headers/footers in every view.

## Partials (37signals Pattern)

5. **Favor partials over ViewComponent**: Standard Rails partials are preferred. They're simpler with less class overhead, plus Rails has solid partial caching.

6. **Extract repeated code to partials**: DRY up views with partials for reused elements.

7. **Name partials with underscore prefix**: `_form.html.erb`, `_card.html.erb`.

8. **Partial naming by concern**: Organize by purpose:
   - `_form` - forms for the resource
   - `_preview` - compact display
   - `_card` - full item display
   - `_container` - wrapper with context

9. **Use collections for rendering lists**:
   ```erb
   <%# Good - uses partial naming convention %>
   <%= render @users %>

   <%# Also good - explicit partial %>
   <%= render partial: 'user', collection: @users %>
   ```

## Caching (37signals Pattern)

10. **Fragment cache keys include context**: Account for factors affecting output:
    ```erb
    <% cache [card, Current.user, timezone_from_cookie] do %>
      <%= render 'cards/card', card: card %>
    <% end %>
    ```

11. **Collection caching with `cached: true`**:
    ```erb
    <%= render partial: 'cards/preview', collection: @cards, cached: true %>
    ```

12. **Touch chains for cache invalidation**: Define `touch: true` in associations to automatically invalidate parent caches.

13. **Design caching early (37signals)**: It reveals architectural constraints. User-specific logic should move to client-side handlers.

14. **Avoid `Current.user` in cached partials**: Breaks cache sharing.

## HTTP Caching (37signals)

15. **ETag-based freshness**: Use composite keys:
    ```ruby
    fresh_when etag: [@card, Current.user, timezone_from_cookie]
    ```

## DOM IDs (37signals Pattern)

16. **Use `dom_id()` helper consistently**:
    ```erb
    <div id="<%= dom_id(card) %>">           <%# card_123 %>
    <div id="<%= dom_id(card, :preview) %>"> <%# preview_card_123 %>
    <div id="<%= dom_id(card, :comments) %>"><%# comments_card_123 %>
    ```

17. **Ensure unique IDs**: Duplicate IDs break Turbo morphing.

## Helpers

18. **Use helpers for formatting**: Date, currency, text truncation.

19. **Extract logic to helpers or model methods (37signals)**: Not partials with minimal markup:
    ```ruby
    # If a partial is just logic with no markup, it should be a method
    # Bad: _status_text.html.erb with just <%= card.status.humanize %>
    # Good: card.status_text method
    ```

20. **Helpers receive explicit parameters (37signals)**: Avoid relying on magical instance variables:
    ```ruby
    # Good
    def card_status_badge(card)
      content_tag :span, card.status, class: "badge badge-#{card.status}"
    end

    # Avoid - implicit @card dependency
    def card_status_badge
      content_tag :span, @card.status, class: "badge badge-#{@card.status}"
    end
    ```

21. **Use `content_tag` over raw HTML**: When generating HTML in helpers.

22. **Be careful with `html_safe`**: Only use on content you control.

23. **Tag helpers with double-indent attributes (37signals)**:
    ```ruby
    tag.meta(
        name: "description",
        content: @page.description
    )
    ```

## Turbo Streams (37signals Pattern)

24. **Partial updates with Turbo Streams**: Target specific DOM elements:
    ```ruby
    turbo_stream.replace dom_id(@card), partial: "cards/card", locals: { card: @card }
    turbo_stream.update dom_id(@card, :comments), partial: "cards/comments"
    turbo_stream.before dom_id(@card), partial: "cards/new_card"
    ```

25. **Morphing for complex changes**: Preserves form focus and input state:
    ```ruby
    turbo_stream.replace dom_id(@card, :container),
      partial: "cards/container",
      method: :morph
    ```

26. **Scope broadcasts in multi-tenant systems**: Prefix targets with account:
    ```ruby
    broadcast_to [Current.account, card]
    ```

## Forms

27. **Use `form_with` over `form_for`**: Modern approach (Rails 5.1+).

28. **Use form builder helpers**: Prefer Rails form helpers over raw HTML.

29. **Always include labels**: For accessibility.

30. **Use `collection_select` for associations**.

31. **Structure forms in Turbo Frames (37signals)**: Prevent state loss during partial updates.

## I18n

32. **Use I18n for all user-facing text**: No hardcoded strings.

33. **Use lazy lookup in views**: Rails looks up based on view path.

## Security

34. **Never output unescaped user content**: ERB auto-escapes.

35. **Use `sanitize` for user HTML**: When users can input HTML.

36. **CSRF tokens in forms**: `form_with` includes automatically.

## Stimulus Integration (37signals)

37. **Integrate Stimulus via helpers**: Create helpers that wire Stimulus data attributes:
    ```ruby
    def auto_submit_form_with(**options, &block)
      form_with(
        **options,
        data: { controller: "auto-submit", action: "change->auto-submit#submit" },
        &block
      )
    end

    def dialog_tag(&block)
      tag.dialog(data: { controller: "dialog" }, &block)
    end
    ```

## Assets & Performance

38. **Use asset helpers**: For images, stylesheets, and scripts.

39. **Use `content_for` for section-specific content**.

## What to Avoid (37signals)

40. **Avoid ViewComponent**: Stick with ERB partials.

41. **Avoid decorators/presenters**: Use view helpers and model methods.

42. **Avoid Tailwind CSS (37signals preference)**: Write native CSS with cascade layers. Modern CSS has variables and nesting.
