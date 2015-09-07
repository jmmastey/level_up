Feature: Enroll in a course
  Because I want to get through training
  As a new user
  I want to be able to enroll in courses

  Background:
    Given I am logged in
    And there is a published course called "Welcome"

  @javascript
  Scenario: Enroll in a course
    Given I visit the courses page
    When I click on the "welcome" enroll button
    Then I see the "welcome" course page
    And I have been enrolled in "welcome"
