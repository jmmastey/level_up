Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Want to be able to sign out

    Scenario: User signs out
      Given I am logged in
      When I sign out
      Then I see a signed out message
      When I return to the site
      Then I am signed out
