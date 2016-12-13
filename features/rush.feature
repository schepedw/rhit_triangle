Feature: Viewing the rush page
  As a rushee
  I would like to learn more about Triangle's rush process

  @javascript
  Scenario: Viewing upcoming events
    Given I have several events this month
    When I am on the rush page
    Then I should see details of my upcoming events

  Scenario: FAQs
    Given I am on the rush page
    Then I should see frequently asked questions
    And I should see the answers to these questions
