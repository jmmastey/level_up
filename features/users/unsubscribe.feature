Feature: Unsubscribe from emails
  As a registered user who's training
  I want to unsubscribe from emails
  Because I don't see value in them

  Scenario: Unsubscribe while logged in
    Given I am logged in
    When I visit the unsubscribe page
    Then I am on the unsubscribe confirmation page
    When I click on unsubscribe
    Then I am unsubscribed
    And I see a message that I am unsubscribed

  Scenario: Unsubscribe via an email
    Given I am not logged in
    When I visit unsubscribe with a token
    Then I am unsubscribed
    And I see a message that I am unsubscribed

  Scenario: Unsubscribe via profile
    Given I am logged in
    When I visit my profile
    Then I see a link to unsubscribe from emails
