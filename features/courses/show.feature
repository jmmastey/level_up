Feature: Show courses
  In order to see the available courses to study
  As a user
  I want to be able to view the courses


  Scenario: View courses as a guest
    Given I am not logged in
    And there is a published course called "Test 1"
    When I visit the courses page
    Then I see the published course called "Test 1"

  Scenario: View courses as a registered user
    Given I am logged in
    And there is a published course called "Test 3"
    And there is an approved course called "Test 4"
    And I am enrolled in "Test 4"
    When I visit the courses page
    Then I see the published course called "Test 3" 
    And I see the approved course called "Test 4"
