Feature: Enroll in a course
  Because I want to get through training
  As a new user
  I want to be able to enroll in courses

  Background:
    Given I am logged in
    And there is a published course called "Test 1"

  @javascript
  Scenario: Enroll in a course
    Given I visit the courses page
    When I click on the "test_1" enroll button
    Then I see the "test_1" course page
    And I have been enrolled in "test_1"
