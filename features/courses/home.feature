Feature: Show courses
  In order to study
  As a user
  I want to be able to view the courses I'm enrolled in


  Scenario: View homepage
    Given I am logged in
    And there is a published course called "Test 1"
    And I am enrolled in "Test 1"
    When I visit the homepage
    Then I see the published course called "Test 1"
