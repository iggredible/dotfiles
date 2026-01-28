# Routing Review Rules

Curated rules for reviewing Rails routes, merged from thoughtbot, rubocop, and 37signals style guides.

## Core Principles (37signals)

1. **Everything is CRUD**: Map every action to Create, Read, Update, or Destroy operations. Avoid custom action methods.

2. **Convert verbs to nouns**: Transform action verbs into noun-based resources:
   ```ruby
   # Instead of
   resources :cards do
     member do
       post :close
       post :pin
     end
   end

   # Use
   resources :cards do
     resource :closure, only: [:create, :destroy]
     resource :pin, only: [:create, :destroy]
   end
   ```

3. **Standard REST verbs align with controller actions**: `POST` → `create`, `DELETE` → `destroy`.

## RESTful Routes

4. **Prefer resourceful routes**: Use `resources` and `resource` over individual route definitions.

5. **Use `resource` for singletons**: When a resource has one-per-parent relationship:
   ```ruby
   resource :closure      # POST to close, DELETE to reopen
   resource :pin          # POST to pin, DELETE to unpin
   ```

6. **Use `resources` for collections**: When multiple child items exist:
   ```ruby
   resources :comments    # Multiple comments per card
   ```

7. **Limit to needed actions**: Don't generate unused routes:
   ```ruby
   resources :posts, only: [:index, :show]
   ```

## Nested Routes

8. **Nest routes for parent-child relationships**: When resources belong to other resources.

9. **Shallow nesting over deep hierarchies (37signals)**: Use `shallow: true` to prevent excessively nested URLs:
   ```ruby
   resources :posts do
     resources :comments, shallow: true
   end
   # /posts/:post_id/comments (index, create)
   # /comments/:id (show, edit, update, destroy)
   ```

10. **Limit nesting depth to one level**: Never nest more than one level deep.

## Module Scoping (37signals Pattern)

11. **Use `scope module:` for grouping without URL prefix**:
    ```ruby
    resources :cards do
      scope module: :cards do
        resource :closure
        resource :pin
        resources :comments
      end
    end
    ```

12. **Controller locations match resource hierarchy**:
    ```ruby
    # app/controllers/cards/closures_controller.rb
    class Cards::ClosuresController < ApplicationController
    end
    ```

## Namespaces & Scopes

13. **Use `namespace` for admin sections**: Provides module, path prefix, and URL prefix:
    ```ruby
    namespace :admin do
      resources :users
    end
    ```

14. **Path-based multi-tenancy (37signals)**: Include tenant ID in URL prefix:
    ```ruby
    scope "/:account_id" do
      resources :cards
    end
    ```

15. **API versioning with namespaces**:
    ```ruby
    namespace :api do
      namespace :v1 do
        resources :users
      end
    end
    ```

16. **My:: namespace for current user resources (37signals)**: Signal no `/:id` route exists:
    ```ruby
    namespace :my do
      resource :profile
      resources :notifications
    end
    ```

## Unified Controllers (37signals Pattern)

17. **Single controller for API and web**: Use `respond_to` blocks instead of separate API namespaces:
    ```ruby
    def show
      respond_to do |format|
        format.html
        format.json { render json: @card }
      end
    end
    ```

18. **Implicit response formats (37signals)**: No need for `respond_to` when both `.html` and `.json` templates exist.

## Polymorphic URLs (37signals)

19. **Use `resolve` blocks for custom URL generation**: Enable `polymorphic_url` and `url_for` helpers:
    ```ruby
    resolve("Closure") { |closure| card_closure_path(closure.card) }
    ```

## Route Constraints

20. **Use constraints for format restrictions**:
    ```ruby
    constraints(id: /\d+/) do
      resources :users
    end
    ```

21. **Subdomain constraints**: Route based on subdomain.

22. **Custom constraint classes**: For complex routing logic.

## Path & URL Helpers

23. **Use path helpers, not hardcoded paths**: Always use generated helpers.

24. **Prefer `_path` over `_url`**: Use `_url` only for emails and external redirects.

## Organization

25. **Order routes consistently**:
    1. Root route
    2. Concerns
    3. Non-resourceful routes (static pages)
    4. Namespaced routes (admin, API)
    5. Main application resources

26. **Use concerns for shared routes**: DRY up repeated nested resources:
    ```ruby
    concern :commentable do
      resources :comments, only: [:index, :create]
    end

    resources :posts, concerns: :commentable
    resources :photos, concerns: :commentable
    ```

27. **Define root route**: Always have a root.

28. **Keep routes file readable**: Extract to separate files if too long.

## Named Routes

29. **Use `as:` for custom names**: When default names aren't clear:
    ```ruby
    get '/login', to: 'sessions#new', as: :login
    ```

30. **Collection and member routes**: Use sparingly—prefer new resources instead.

## HTTP Verbs

31. **Use appropriate HTTP methods**:
    - GET: Read/retrieve (no side effects)
    - POST: Create new resource or state change
    - PATCH: Update existing resource
    - DELETE: Remove resource

32. **POST for state toggles (37signals)**: Use POST method for state changes, not GET.

33. **Avoid GET for state changes**: GETs should be safe and idempotent.

## Response Codes (37signals)

34. **Create returns 201 with Location header**:
    ```ruby
    head :created, location: card_path(@card)
    ```

35. **Update/Delete returns 204**:
    ```ruby
    head :no_content
    ```

## Security

36. **No sensitive data in URLs**: Don't put tokens or secrets in GET parameters.

37. **Protect against route enumeration**: Use UUIDs or slugs instead of sequential IDs when appropriate.

## Links (37signals Pattern)

38. **Links over JavaScript**: Use plain `<a>` tags for filter chips and navigation—enables native browser affordances.
