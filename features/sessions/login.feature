Feature: Login
    In order to use system
    As a user
    I should be able to login into my account

    Background: I have account
        Given I have account

    @todo @critical
    Scenario: User should be able to login
        When I enter my credentials correctly and try to login
        Then I should be successfully logged in in the system

    @todo @critical
    Scenario: User should be able to login only if credentials match
        When I enter my credentials incorrectly and try to login
        Then I shouldn't be logged in
        And Error should appear saying "Wrong credentials"
