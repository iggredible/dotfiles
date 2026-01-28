# Testing Review Rules

Curated rules for reviewing Rails tests, merged from thoughtbot, rubocop, and 37signals style guides.

## Framework Selection (37signals)

1. **Consider Minitest over RSpec**: 37signals prefers Minitest because it:
   - Offers simplicity with less DSL magic
   - Ships with Rails
   - Has faster boot times
   - Relies on plain Ruby assertions

   Note: Many teams successfully use RSpec. Choose what works for your team.

## Test Data (37signals Pattern)

2. **Consider fixtures over factories**: For deterministic, preloaded test data:
   ```yaml
   # test/fixtures/users.yml
   david:
     identity: david
     account: basecamp
     role: admin

   jane:
     identity: jane
     account: basecamp
     role: member
   ```

3. **Use labels instead of IDs**: For fixture relationships:
   ```yaml
   urgent_bug:
     title: "Fix login issue"
     creator: david
     board: engineering
   ```

4. **ERB for dynamic fixture values**: Handle time-dependent data:
   ```yaml
   recent_post:
     title: "New Feature"
     created_at: <%= 1.day.ago %>
   ```

## General Principles

5. **Test behavior, not implementation**: Verify outcomes, not internal details:
   ```ruby
   # Good - tests behavior
   assert_equal 'John Doe', user.full_name

   # Avoid - tests implementation
   expect(user).to receive(:first_name).and_return('John')
   ```

6. **One assertion per test (generally)**: Each test should verify one behavior.

7. **Tests should be independent**: No test should depend on another's state.

8. **Prefer integration tests over unit tests**: System tests and request specs provide more value.

9. **Ship tests alongside features (37signals)**: Same commit and pull request.

10. **Include regression tests with security fixes**.

## Test Organization

11. **Setup blocks for shared objects (Minitest)**:
    ```ruby
    setup do
      @card = cards(:urgent_bug)
      @user = users(:david)
    end
    ```

12. **Use `let` for lazy evaluation (RSpec)**: Cleaner than instance variables:
    ```ruby
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    ```

13. **Follow Arrange-Act-Assert pattern**: Structure tests clearly.

## RSpec Style (if using RSpec)

14. **Use `describe` for classes/methods, `context` for states**:
    ```ruby
    describe User do
      describe '#full_name' do
        context 'when user has both names' do
          it 'combines first and last name'
        end
      end
    end
    ```

15. **Start `context` with 'when' or 'with'**.

16. **Start `it` with a verb**: `it 'creates a new user'`.

17. **Avoid 'should' in descriptions**: Redundant with expectation syntax.

## Minitest Style (37signals)

18. **Use `assert_difference` for state changes**:
    ```ruby
    assert_difference "Event.count", 1 do
      @card.close(by: @user)
    end
    ```

19. **Plain assertions**: Direct and simple:
    ```ruby
    assert user.valid?
    assert_equal "John Doe", user.full_name
    assert_nil user.deleted_at
    ```

## Factories (if using FactoryBot)

20. **Minimal factories**: Define only required attributes.

21. **Use traits for variations**:
    ```ruby
    factory :user do
      trait :admin do
        role { 'admin' }
      end
    end
    ```

22. **Prefer `build` over `create`**: When database persistence isn't needed.

23. **Use `build_stubbed` for read-only tests**: Fastest option.

## Time Handling

24. **Use `travel_to` for time-dependent tests**:
    ```ruby
    travel_to 25.hours.from_now do
      assert token.expired?
    end
    ```

25. **Freeze time for consistent results**: Avoid flaky tests.

26. **Don't assert exact times**: Use ranges or tolerances.

## HTTP & External Services

27. **Stub external HTTP requests**: Use WebMock or VCR.

28. **VCR for complex integrations (37signals recommends)**: Record and replay HTTP interactions:
    ```ruby
    VCR.use_cassette('stripe/create_customer') do
      customer = StripeService.create_customer(user)
      assert customer.id.present?
    end
    ```

29. **Disable external requests in test suite**: Fail fast on unexpected HTTP.

## Background Jobs

30. **Test job enqueueing with `assert_enqueued_with`**:
    ```ruby
    assert_enqueued_with(job: NotificationJob, args: [@user]) do
      @card.close(by: @user)
    end
    ```

31. **Verify execution with `perform_enqueued_jobs`**:
    ```ruby
    perform_enqueued_jobs do
      @card.close(by: @user)
    end
    assert_equal 1, Notification.count
    ```

## Test-Induced Design Damage (37signals)

32. **Never modify application code solely for testability**: Use mocks or fixtures instead:
    ```ruby
    # Bad - adding code just for tests
    def initialize(clock: Time)
      @clock = clock
    end

    # Good - use travel_to in tests
    travel_to specific_time do
      # test code
    end
    ```

33. **Add fixtures you can use**: Instead of modifying production code to accept test doubles.

## Request/Integration Tests

34. **Test API endpoints with request tests**:
    ```ruby
    test "creates a user" do
      post api_users_path, params: { user: { email: 'test@example.com' } }

      assert_response :created
      assert_equal 'test@example.com', json_response['email']
    end
    ```

35. **Test response status and body separately**: Clear failure messages.

## System Tests

36. **Use Capybara matchers**: More reliable than direct assertions.

37. **Wait for async operations**: Capybara auto-waits, be explicit when needed.

38. **Test happy path first**: Then edge cases.

## Turbo Test Assertions (37signals)

39. **Assert Turbo Frames**:
    ```ruby
    assert_turbo_frame "comments", loading: "lazy"
    assert_turbo_frame @user, :profile, target: "_top"
    assert_no_turbo_frame "admin-panel"
    ```

## Model Tests

40. **Test validations** (RSpec with shoulda-matchers):
    ```ruby
    it { is_expected.to validate_presence_of(:email) }
    ```

41. **Test associations**:
    ```ruby
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    ```

42. **Test scopes with real data**: Not just that they return a relation.

## What to Avoid (37signals)

43. **Avoid RSpec (37signals preference)**: Minitest is simpler with faster boot times. However, RSpec is widely used and acceptable.

44. **Avoid FactoryBot (37signals preference)**: Fixtures are faster with explicit, deterministic data. However, factories work well for many teams.

45. **Avoid excessive mocking**: Prefer real objects. Mocks can hide bugs.
