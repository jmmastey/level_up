Feature: Complete and uncomplete skills
  I really want to get into a team
  So as a new developer
  I want to check off all my skills so that I can leave training

  Background:
    Given I am logged in
    And I am enrolled in a course called "Faux"

  @javascript
  Scenario: I'm super rad so I complete a skill
    Given I visit a course page
    When I click on a completion checkbox
    And I wait for Ajax to finish
    Then I should have completed that skill
 
  @javascript
  Scenario: I fat-fingered so I need to uncomplete a skill
    Given I completed a skill
    And I visit a course page
    When I click on a completion checkbox
    And I wait for Ajax to finish
    Then I should not have completed that skill

  Scenario: I get stuck in my progress and need help
    Given I completed a skill a long time ago
    When I visit a course page
    Then I should see a friendly help message

  Scenario: I'm no longer stuck so I don't need help
    Given I completed a skill recently
    When I visit a course page
    Then I shouldn't see any help message because I'm not stuck
