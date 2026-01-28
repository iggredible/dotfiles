# Model Review Rules

Curated rules for reviewing ActiveRecord models, merged from thoughtbot, rubocop, and 37signals style guides.

## Class Structure & Organization

1. **Macro ordering**: Organize model macros in this order:
   - `include` statements (concerns)
   - `extend` statements
   - Constants
   - `attr_*` declarations
   - Enums
   - Associations (`belongs_to`, `has_one`, `has_many`, `has_and_belongs_to_many`)
   - Validations
   - Callbacks
   - Scopes
   - Class methods (`self.method_name`)
   - Instance methods

2. **Association ordering**: Group associations by type in this order: `belongs_to`, `has_one`, `has_many`, `has_and_belongs_to_many`.

3. **Validation ordering**: Group validations by type, then alphabetically by attribute.

## Concerns (37signals Pattern)

4. **Use concerns heavily**: Models should incorporate multiple concerns, each handling one specific aspect of horizontal behavior:
   ```ruby
   class Card < ApplicationRecord
     include Closeable
     include Watchable
     include Assignable
     include Taggable
     include Searchable
   end
   ```

5. **Concern structure**: Each concern should be self-contained with associated relationships, scopes, and methods:
   ```ruby
   module Card::Closeable
     extend ActiveSupport::Concern

     included do
       has_one :closure, dependent: :destroy
       scope :closed, -> { joins(:closure) }
       scope :open, -> { where.missing(:closure) }
     end

     def closed?
       closure.present?
     end

     def close(by:)
       create_closure!(creator: by)
     end
   end
   ```

6. **Concern size guidelines**: Each concern should be 50-150 lines, cohesive, and named for the capability it provides: `Closeable`, `Watchable`, `Assignable`.

## State Management (37signals Pattern)

7. **State as records, not booleans**: Create separate record classes instead of boolean columns to capture when state changed and who made the change:
   ```ruby
   # Avoid
   class Card < ApplicationRecord
     scope :closed, -> { where(closed: true) }
   end

   # Prefer
   class Closure < ApplicationRecord
     belongs_to :card, touch: true
     belongs_to :creator, class_name: "User", optional: true
   end

   class Card < ApplicationRecord
     has_one :closure, dependent: :destroy
     scope :closed, -> { joins(:closure) }
     scope :open, -> { where.missing(:closure) }
   end
   ```

8. **Query patterns with state records**: Use `joins` for presence and `where.missing` for absence:
   ```ruby
   Card.open                    # where.missing(:closure)
   Card.closed                  # joins(:closure)
   Card.active                  # open.published.where.missing(:not_now)
   ```

## Associations

9. **Use `dependent` option**: Always specify `dependent` on `has_many` and `has_one`. Prefer `:delete_all` when callbacks aren't needed for performance.

10. **Prefer `has_many :through`**: Use `has_many :through` over `has_and_belongs_to_many` for flexibility.

11. **Use `inverse_of`**: Specify when association name differs from class name.

12. **Lambda-based defaults (37signals)**: Use lambdas for dynamic default values:
    ```ruby
    class Card < ApplicationRecord
      belongs_to :account, default: -> { board.account }
      belongs_to :creator, class_name: "User", default: -> { Current.user }
    end
    ```

13. **Touch for cache invalidation**: Use `touch: true` to propagate cache invalidation:
    ```ruby
    belongs_to :card, touch: true
    ```

## Validations

14. **Minimal validations (37signals)**: Keep model validations simple and essential. Prefer database constraints:
    ```ruby
    class Account < ApplicationRecord
      validates :name, presence: true
    end
    ```

15. **Database over ActiveRecord validations**: Let the database enforce integrity when possible. DB constraint violations work fine.

16. **Contextual validations**: Use validation contexts for multi-step flows:
    ```ruby
    class Signup
      validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP },
        on: :identity_creation
      validates :full_name, :identity, presence: true, on: :completion
    end
    ```

17. **Combine validations on same attribute**: Group multiple validations:
    ```ruby
    validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
    ```

## Callbacks

18. **Use callbacks sparingly**: Only for setup/cleanup, never for business logic:
    ```ruby
    class MagicLink < ApplicationRecord
      before_validation :generate_code, on: :create
    end
    ```

19. **Prefer `after_commit` over `after_save`**: For external service calls or notifications, use `after_commit` to ensure the transaction succeeded.

20. **Use `after_save_commit` shorthand (37signals)**: Cleaner than `after_commit on: %i[create update]`.

21. **No external API calls in callbacks**: Move external service calls to background jobs.

## Scopes

22. **Business-focused naming (37signals)**: Name scopes for domain concepts, not SQL patterns:
    ```ruby
    # Good
    scope :active, -> { where.missing(:pop) }
    scope :unassigned, -> { where.missing(:assignments) }
    scope :golden, -> { joins(:goldness) }

    # Avoid
    scope :without_pop, -> { ... }
    scope :no_assignments, -> { ... }
    ```

23. **Common scope patterns**:
    ```ruby
    # Status
    scope :open, -> { where.missing(:closure) }
    scope :closed, -> { joins(:closure) }

    # Ordering
    scope :alphabetically, -> { order(title: :asc) }
    scope :recently_created, -> { order(created_at: :desc) }

    # Filtering
    scope :created_by, ->(user) { where(creator: user) }
    scope :assigned_to, ->(user) { joins(:assignments).where(assignments: { user: user }) }

    # Preloading
    scope :preloaded, -> { includes(:creator, :board, :tags, :assignments) }
    ```

24. **Use lambda syntax**: Always use stabby lambda for scopes.

25. **Avoid default scopes**: Default scopes cause unexpected behavior.

26. **Chain-friendly scopes**: Return ActiveRecord::Relation for chaining.

## Current Context (37signals Pattern)

27. **Use Current for request context**: Leverage `ActiveSupport::CurrentAttributes`:
    ```ruby
    class Current < ActiveSupport::CurrentAttributes
      attribute :session, :user, :identity, :account
      attribute :http_method, :request_id, :user_agent, :ip_address
    end
    ```

28. **Access Current in models**: Use `Current.user`, `Current.account` for contextual defaults.

## Queries & Performance

29. **Avoid N+1 queries**: Use `includes`, `preload`, or `eager_load`.

30. **Use `find_each` for batch processing**: Never load large datasets into memory.

31. **Prefer `exists?` over `any?`**: For checking record existence.

32. **Use `pluck` for single columns (37signals)**: Instead of `map(&:name)`:
    ```ruby
    User.where(active: true).pluck(:email)
    ```

33. **Use counter caches (37signals)**: Pre-compute counts at write time:
    ```ruby
    belongs_to :post, counter_cache: true
    ```

34. **Write-time over read-time operations (37signals)**: Perform manipulation during save, not presentation.

## Bang Methods (37signals Pattern)

35. **Let it crash**: Use bang methods (`create!`, `save!`) to raise exceptions on failure:
    ```ruby
    def create
      @comment = @card.comments.create!(comment_params)
    end
    ```

## POROs (37signals Pattern)

36. **Use POROs for presentation logic**: Not service objects:
    ```ruby
    class Event::Description
      def initialize(event)
        @event = event
      end

      def to_s
        case event.action
        when "created" then "#{creator_name} created this card"
        when "closed"  then "#{creator_name} closed this card"
        end
      end
    end
    ```

37. **Avoid service objects**: Keep model-adjacent code in models or POROs, not controller-adjacent services.

## Data Integrity

38. **Boolean columns need defaults**: Always set `default: false` and `null: false`.

39. **Use enums with explicit values**:
    ```ruby
    enum status: { pending: 0, approved: 1, rejected: 2 }
    ```

40. **Use `normalizes` for data consistency (Rails 7.1+)**: Clean data before validation:
    ```ruby
    normalizes :email, with: ->(email) { email.strip.downcase }
    ```

## Naming Conventions

41. **Model names are singular**: `User` not `Users`.

42. **Boolean attributes use positive names (37signals)**: Avoid negatives like `not_popped`:
    ```ruby
    # Good
    :active, :published, :verified

    # Avoid
    :is_not_deleted, :not_popped
    ```

43. **Method names reflect return values (37signals)**: `collect` implies array, use `create_mentions` when ignoring return.

## Rails Utilities (37signals)

44. **StringInquirer for predicates**: Use `.inquiry` for readable action checks:
    ```ruby
    event.action.inquiry.completed?  # Instead of event.action == "completed"
    ```

45. **Store accessor for JSON columns**: Enables type casting and cleaner API:
    ```ruby
    store_accessor :settings, :notifications_enabled, :theme
    ```

46. **Delegated types for polymorphism**: Automatically provides convenience methods.
