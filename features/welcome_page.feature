Feature: Viewing the RHIT triangle homepage
  As a visitor
  I would like to view the homepage
  So I may quickly gain knowledge about RHIT Triangle
  And navigate to various locations on the site to learn more knowledge

  @javascript
  Scenario: Viewing the calendar
    Given I have an event today
    When I am on the home page
    Then I should see details of today's event

  @javascript
  Scenario: Viewing the calendar
    Given I have an event tomorrow
    When I am on the home page
    Then I should see that I have an event tomorrow

  @javascript
  Scenario: Viewing tweets
    Given Rose Triangle has tweeted
    When I am on the home page
    Then I should see the tweets

  Scenario: Navigating to the calendar
    Given I am on the home page
    When I click 'CALENDAR' in the nav bar
    Then I will be directed to the calendar page

  Scenario: Navigating to the rush page
    Given I am on the home page
    When I click 'RUSH' in the nav bar
    Then I will be directed to the rush page

  Scenario: Navigating to the alumni page
    Given I am on the home page
    When I click 'ALUMNI' in the nav bar
    Then I will be directed to the alumni page

  Scenario: Navigating to the forum when signed in
    Given I am signed in
    And I am on the home page
    When I click 'FORUM' in the nav bar
    Then I will be directed to the forum

  Scenario: Navigating to the forum when not signed in
    Given I am on the home page
    When I click 'FORUM' in the nav bar
    Then I will be directed home

  Scenario: Navigating to the donations page
    Given I am on the home page
    When I click 'GIVING BACK' in the nav bar
    Then I will be directed to the projects and donations page

  Scenario: Viewing the active officers
    Given there are active officers
    When I am on the home page
    Then I will be able to see details for all of the officers
