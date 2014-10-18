Feature: Sign up
  In order to see how awesome my peers are
  As a user
  I want to be able to see the user list.

    Background:
      Given I am logged in
      And there are other users with completions

    Scenario: User views the listing page
      When I visit the users page
      Then I see all the other users with completions

    Scenario: User clicks on a profile
      Given I visit the users page
      When I click a user's profile link
      Then I see that user's profile
