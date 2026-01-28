# Controller Review Rules

Curated rules for reviewing Rails controllers, merged from thoughtbot, rubocop, and 37signals style guides.

## Thin Controllers, Rich Models

1. **Controllers should be thin orchestrators (37signals)**: Business logic lives in models. Controllers merely call model methods:
   ```ruby
   # Good - controller calls model method
   def update
     @card.close(by: Current.user)
   end

   # Bad - logic in controller
   def update
     @card.update(closed: true, closed_at: Time.current, closed_by: current_user)
   end
   ```

2. **One instance variable per action**: Multiple instance variables suggest the view is doing too much.

3. **Limit actions to 10 lines**: Extract logic to model methods (not service objects).

4. **Start in controllers, extract when needed (37signals)**: Begin implementations in controllers; extract when complexity emerges. Apply the rule of three: duplicate twice before abstracting.

## RESTful Actions

5. **Stick to CRUD actions**: Prefer standard RESTful actions: `index`, `show`, `new`, `create`, `edit`, `update`, `destroy`.

6. **Custom actions indicate missing resources (37signals)**: Convert verbs to nouns:
   ```ruby
   # Instead of
   resources :cards do
     member do
       post :close
     end
   end

   # Use
   resources :cards do
     resource :closure, only: [:create, :destroy]
   end
   ```

7. **Use `respond_to` blocks for format handling**:
   ```ruby
   respond_to do |format|
     format.turbo_stream { render_card_replacement }
     format.json { head :no_content }
   end
   ```

## Concerns (37signals Pattern)

8. **Use concerns for cross-cutting behavior**: Resource scoping, request context, timezone handling:
   ```ruby
   class ApplicationController < ActionController::Base
     include CurrentRequest
     include SetTimezone
     include SetPlatform
   end
   ```

9. **Resource scoping concerns**: Create reusable concerns for nested resources:
   ```ruby
   module CardScoped
     extend ActiveSupport::Concern

     included do
       before_action :set_card
     end

     private

     def set_card
       @card = Card.find(params[:card_id])
     end

     def render_card_replacement
       render turbo_stream: turbo_stream.replace(dom_id(@card), partial: "cards/card")
     end
   end
   ```

10. **Request context via Current (37signals)**: Populate a `Current` object with request metadata:
    ```ruby
    module CurrentRequest
      extend ActiveSupport::Concern

      included do
        before_action :set_current_request_details
      end

      private

      def set_current_request_details
        Current.ip_address = request.ip
        Current.user_agent = request.user_agent
        Current.request_id = request.request_id
      end
    end
    ```

## Filters

11. **Filter ordering**: Organize filters in this order:
    - `before_action`
    - `around_action`
    - `after_action`
    - `skip_before_action`

12. **Use `only` and `except` explicitly**: Always specify which actions a filter applies to.

13. **Timezone via `around_action` (37signals)**:
    ```ruby
    around_action :set_timezone

    def set_timezone(&block)
      Time.use_zone(cookies[:timezone] || "UTC", &block)
    end
    ```

14. **Include timezone in ETags (37signals)**: For proper HTTP cache differentiation.

## Strong Parameters

15. **Use `params.expect` (Rails 7.1+, 37signals)**: Cleaner syntax, returns 400 for invalid params:
    ```ruby
    def card_params
      params.expect(card: [:title, :body])
    end
    ```

16. **Define params in private methods**: Keep controllers clean.

17. **Permit only what's needed**: Never use `.permit!`.

## Response Handling

18. **Use appropriate HTTP status codes**:
    - `201 :created` with `Location` header for creates
    - `204 :no_content` for updates and deletes
    - `422 :unprocessable_entity` for validation failures

19. **Use `head` for empty responses (37signals)**:
    ```ruby
    def update
      @card.update!(card_params)
      head :no_content
    end
    ```

20. **Redirect after successful POST/PUT/DELETE**: Follow Post-Redirect-Get pattern.

21. **Flash via Turbo streams (37signals)**: Deliver flash messages via Turbo streams rather than page reloads.

## Error Handling

22. **Rescue in base controller**: Handle common errors in `ApplicationController`:
    ```ruby
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    ```

23. **Don't rescue generic exceptions**: Never `rescue Exception` or `rescue StandardError`.

24. **Let it crash (37signals)**: Use bang methods and let exceptions propagate for unexpected errors.

## Authorization (37signals Pattern)

25. **Models define permissions, controllers enforce**: Separate definition from enforcement:
    ```ruby
    # Model defines what permission means
    class Card < ApplicationRecord
      def editable_by?(user)
        creator == user || user.admin?
      end
    end

    # Controller enforces it
    before_action :ensure_can_edit, only: [:edit, :update]

    def ensure_can_edit
      head :forbidden unless @card.editable_by?(Current.user)
    end
    ```

26. **Simple predicate methods over policy objects**: For most apps, `editable_by?(user)` on models is sufficient. Pundit/CanCanCan add unnecessary files.

## Security Headers (37signals)

27. **Set security headers**: Prevent indexing of private content:
    ```ruby
    before_action :set_security_headers

    def set_security_headers
      response.headers["X-Robots-Tag"] = "none"
    end
    ```

28. **Use `Sec-Fetch-Site` for CSRF (37signals)**: Alternative to token-based CSRF protection.

## Naming & Structure

29. **Align controller locations with resource hierarchy (37signals)**:
    ```ruby
    # app/controllers/cards/closures_controller.rb
    class Cards::ClosuresController < ApplicationController
      include CardScoped

      def create
        @card.close(by: Current.user)
        respond_to do |format|
          format.turbo_stream { render_card_replacement }
          format.json { head :created, location: card_path(@card) }
        end
      end
    end
    ```

30. **Minimal ApplicationController (37signals)**: Include only essential cross-cutting concerns. Keep base controller focused on authentication, authorization, and request setup.

31. **Unified API/Web controllers (37signals)**: Use single controller with `respond_to` blocks. Avoid separate API namespaces unless truly needed.

32. **Keep private methods at bottom**: Public actions first, then private helper methods.

## What to Avoid (37signals)

33. **Avoid service objects**: Rich domain models with focused methods are preferred. Services fragment logic.

34. **Avoid form objects**: Rely on strong parameters and model validations. Only consider for complex multi-model situations.

35. **Avoid decorators/presenters**: Use view helpers and partials instead.
