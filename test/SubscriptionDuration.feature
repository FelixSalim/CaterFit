Feature: Choose Subscription Duration

    Scenario: User selects a subscription duration
        Given the user is on the Package Detail Screen
        When the user click the "Subscribe Now" button
        Then the user should see "1 month" as my selected subscription duration
    
    Scenario: Decrement button is disabled when week count is 1
        Given the user is on the Package Detail Screen
        And the subscription duration is 1 week
        When the user clicks the decrement button
        Then the decrement button does not change the subscription duration
        And the subscription duration remains 1 week
    
    Scenario: The user increase the subscription duration
        Given the user is on the Package Detail Screen
        And the current week count is less than the stock
        When the user clicks the increment button
        Then the subscription duration should increase by 1 week
        And the user should see the updated subscription duration

    Scenario: The user decrease the subscription duration
        Given the user is on the Package Detail Screen
        And the current week count is more than 1
        When the user taps the decrement button
        Then the subscription week count decreases by 1
        And the screen shows the updated week count

    Scenario: The user increase the subscription duration but the stock is not available
        Given the user is on the Package Detail Screen
        And the current week count is equal to the stock
        When the user taps the increment button
        Then the user should see a message "Stock not available"
        And the subscription duration should not change
    