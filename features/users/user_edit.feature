Feature: Edit User
  As a registered user of the website
  I want to edit my user profile
  So I can change my username

    Scenario: I sign in and edit my account
      Given I am logged in
      When I edit my account details
      Then I see an account edited message
