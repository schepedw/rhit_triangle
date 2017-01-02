Feature: Interacting with the forum
  As a member
  I would like to communicate with fellow members

  Background:
    Given I am signed in
    And there is a forum channel

  Scenario: Visiting the forum
    Given I am not signed in
    When I visit the forum page
    Then I will be redirected to the members sign in page

  @javascript
  Scenario: Viewing channel content
    Given the forum channel has at least one post
    And I am on the forum page
    When I visit that channel
    Then I will see the posts for the channel
    And I will see the member count and description of that channel

  @javascript
  Scenario: Changing channels
    Given there are multiple forum channels
    And I visit the forum page
    When I click a new channel
    Then I will see the posts for the channel
    And I will see the member count and description of that channel

  @javascript
  Scenario: Posting in a channel
    Given I am on the forum page
    When I post in the channel
    Then I will see my post in that channel's contents

  @javascript
  Scenario: Liking a post
    Given the forum channel has at least one post
    And I am on the forum page
    When I like a post
    Then I will see that the post has been liked

  @javascript
  Scenario: Unliking a post
    Given the forum channel has at least one post
    And I have liked that post
    And I am on the forum page
    When I unlike a post
    Then I will see that the post has been unliked

  @javascript
  Scenario: Editing my posts
    Given I have written at least one post
    And I am on the forum page
    When I edit my post
    Then the change to my post will be saved

  @javascript
  Scenario: Trying to edit someone else's posts
    Given the forum channel has at least one post by someone else
    And I am on the forum page
    Then I will not have the ability to edit that post

  @javascript
  Scenario: Deleting my posts
    Given I have written at least one post
    And I am on the forum page
    When I delete my post
    Then then the post will be deleted

  @javascript
  Scenario: Trying to delete someone else's posts
    Given the forum channel has at least one post by someone else
    And I am on the forum page
    Then I will not have the ability to delete that post

  @javascript
  Scenario: Replying to a post
    Given the forum channel has at least one post
    And I am on the forum page
    When I reply to a post
    Then my reply will be visible
