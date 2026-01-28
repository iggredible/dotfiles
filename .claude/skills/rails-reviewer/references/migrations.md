# Migration Review Rules

Curated rules for reviewing Rails database migrations, merged from thoughtbot, rubocop, and 37signals style guides.

## Migration Structure

1. **One concern per migration**: Each migration should do one thing. Don't combine schema changes with data migrations.

2. **Descriptive migration names**: Name migrations clearly:
   ```ruby
   # Good
   AddEmailIndexToUsers
   RemoveDeprecatedFieldsFromOrders
   CreateUserPreferences

   # Bad
   UpdateUsersTable
   FixData
   ```

3. **Use `change` when possible**: Prefer `change` over `up/down` for reversible migrations.

4. **Explicit `up/down` for data migrations**: When `change` isn't reversible, use explicit methods.

## Primary Keys (37signals Pattern)

5. **Consider UUIDs over auto-incrementing integers**: Prevents ID enumeration attacks, supports distributed systems:
   ```ruby
   create_table :cards, id: :uuid do |t|
     t.references :board, type: :uuid, foreign_key: true
     t.string :title
     t.timestamps
   end
   ```

6. **UUIDv7 for time-sortable IDs (37signals)**: Base36-encoded as 25-character strings for readability.

## State Management (37signals Pattern)

7. **Replace booleans with state records**: Capture WHO and WHEN:
   ```ruby
   # Instead of adding a boolean
   add_column :cards, :closed, :boolean, default: false

   # Create a state table
   create_table :closures do |t|
     t.references :card, null: false, foreign_key: true
     t.references :creator, foreign_key: { to_table: :users }
     t.timestamps
   end
   ```

## Column Definitions

8. **Always specify `null` constraints**: Be explicit about nullability:
   ```ruby
   add_column :users, :name, :string, null: false
   add_column :posts, :subtitle, :string, null: true  # Optional field
   ```

9. **Boolean columns require `null: false` and `default`**: Prevent three-state booleans:
   ```ruby
   add_column :users, :active, :boolean, null: false, default: true
   ```

10. **Set defaults at database level**: For new non-null columns on existing tables.

11. **Use `text` over `string` for unbounded content**: If length is unknown or potentially long.

12. **Specify `limit` for strings when appropriate**: For bounded data like status codes.

## Indexes

13. **Add indexes for foreign keys**: Every `_id` column should have an index:
    ```ruby
    add_reference :posts, :user, foreign_key: true, index: true
    ```

14. **Index columns used in WHERE clauses**: If you query by a column frequently, index it.

15. **Use `unique: true` for unique constraints**: Enforce uniqueness at the database level.

16. **Composite indexes for compound queries (37signals)**: Common query patterns need indexes:
    ```ruby
    add_index :cards, [:account_id, :board_id, :created_at]
    ```

17. **Partial indexes for filtered queries**: Use `where` for indexes on subsets.

18. **Name long indexes explicitly**: Rails auto-generates names, but they may be too long.

## Foreign Keys

19. **Always add foreign key constraints**: Use `foreign_key: true` with references.

20. **Specify `on_delete` behavior**: Be explicit about cascade behavior:
    ```ruby
    add_foreign_key :comments, :posts, on_delete: :cascade
    add_foreign_key :orders, :users, on_delete: :nullify
    add_foreign_key :invoices, :accounts, on_delete: :restrict
    ```

21. **Apply foreign keys selectively (37signals)**: Based on data integrity requirements. Omit where application-level handling provides sufficient flexibility.

## Multi-Tenancy (37signals Pattern)

22. **Include `account_id` across models**: Enforce tenant isolation:
    ```ruby
    add_reference :cards, :account, null: false, foreign_key: true, index: true
    ```

23. **Scoped uniqueness constraints**: Include tenant in unique indexes:
    ```ruby
    add_index :cards, [:account_id, :number], unique: true
    ```

## Data Migrations

24. **Separate schema and data migrations**: Don't mix schema changes with data transformations.

25. **Use `update_all` for bulk updates**: Bypass callbacks and validations for performance.

26. **Use SQL for large data migrations**: For millions of records, use raw SQL.

27. **Consider batching large migrations**: Process in chunks to avoid timeouts.

28. **Models in migrations are OK (37signals)**: Migrations can safely reference models to update data—this is intentional, not an antipattern.

## Safety & Reversibility

29. **Test migrations both ways**: Run `rails db:migrate` and `rails db:rollback`.

30. **Use `reversible` for complex operations**:
    ```ruby
    reversible do |dir|
      dir.up { execute "CREATE EXTENSION IF NOT EXISTS hstore" }
      dir.down { execute "DROP EXTENSION hstore" }
    end
    ```

31. **Raise `IrreversibleMigration` when appropriate**: For destructive operations that can't be undone.

32. **Don't remove columns in the same deploy**: Mark as ignored first, deploy, then remove.

33. **Add new columns as nullable first**: For zero-downtime deploys.

## Deletion Strategy (37signals Pattern)

34. **Hard deletes over soft deletes**: Removes complexity from queries. Use event logging or audit tables when historical records are needed.

## Timestamps

35. **Always add timestamps**: Use `timestamps` for new tables.

36. **Timestamps should be non-nullable**:
    ```ruby
    t.timestamps null: false
    ```

## Naming Conventions

37. **Table names are plural**: `users`, `posts`, `order_items`.

38. **Join table names in alphabetical order**: `authors_books` not `books_authors`.

39. **Foreign keys end in `_id`**: `user_id`, `post_id`.

40. **Use snake_case for column names**: `first_name`, `created_at`.

41. **Avoid reserved words**: Don't use `type`, `class`, `module`, etc. as column names (or use `type` only for STI).

## Performance

42. **Add indexes concurrently on large tables**: Prevent table locks:
    ```ruby
    disable_ddl_transaction!

    def change
      add_index :users, :email, algorithm: :concurrently
    end
    ```

43. **Use counter caches (37signals)**: Enable on frequently counted relationships:
    ```ruby
    add_column :posts, :comments_count, :integer, default: 0, null: false
    ```

44. **Use `change_column_null` carefully**: Can lock tables.

45. **Avoid `change_column` on large tables**: Consider add/backfill/remove pattern.

## Infrastructure (37signals Pattern)

46. **Database-backed job queues**: Use Solid Queue over Redis-backed Sidekiq for simpler operations.

47. **Database-backed caching**: Use Solid Cache for unified backup strategies.

48. **Database-backed WebSockets**: Use Solid Cable for ActionCable.
