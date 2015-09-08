Feature: Set and update deadlines
  As a programmer in training
  I want to enable deadline mode
  So that I can keep myself accountable

  Background:
    Given I am logged in
    And I am enrolled in a course called "Faux"

  Scenario: Update deadline mode
    Given I visit my profile
    When I update my deadline preferences
    Then I see my profile updated
    And my deadline preferences are updated

  Scenario: I don't like succeeding, so I don't see deadline prompts
    Given I have deadlines disabled
    When I visit a course page
    Then I don't see any deadline options

  Scenario: Set a deadline because I'm great
    Given I have deadlines enabled
    But I have not set any deadlines
    When I visit a course page
    Then I see the option to set a deadline
    When I choose and submit a deadline
    Then I see my deadline reflected

  Scenario: Undo my deadline out of fear
    Given I have set a deadline
    When I visit a course page
    Then I see a link to remove my deadline
    When I click to undo my deadline
    Then I see the option to set a deadline
