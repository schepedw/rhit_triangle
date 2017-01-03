Feature: Signing into the website
  As a Triangle Fraternity member
  I would like to sign in

  Scenario: Creating an account
    Given I am on the members sign up page
    When I fill in the account fields with valid information
    Then I will have created an account

  Scenario: Logging in successfully
    Given I am on the members sign in page
    And I have an account
    When I enter the proper credentials
    Then I will be signed in
    And I will be directed home

  Scenario: Failing to log in
    Given I am on the members sign in page
    And I have an account
    When I enter improper credentials
    Then I will not be signed in
    And I will be redirected to the members sign in page
    And I will be notified of that I failed to login

  Scenario: Logging out
    Given I am on the members sign in page
    And I have an account
    And I enter the proper credentials
    When I click the sign out button
    Then I will be signed out
