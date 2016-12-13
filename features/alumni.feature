Feature: Viewing the alumni page
  As someone curious about the Triangle Alumni

  Scenario: Viewing the alumni board
    Given there are alumni officers
    When I am on the alumni page
    Then I will be able to see details for all of the officers
