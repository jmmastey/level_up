Feature: User profile
  As a registered user who's training
  I want to view my profile
  So that I can see how my training is going

  Background:
    Given I am logged in

  Scenario: View profile link
    When I return to the site
    Then I should see a profile link in the header

  Scenario: Viewing user progress
    Given a user exists with some training progress
    When I visit a user's profile page
    Then I should see that user's profile
    And I should see their skills
    And I should see their pretty picture
