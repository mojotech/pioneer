Feature: Manipulating Widgets

  Background:
    When I view "sample.html"

  Scenario: Is Present
    When I see if "doge" is present within ".wow" I should get "true"

  Scenario: Is Not Present
    When I see if "dogey" is present within ".wow" I should get "false"

  Scenario: Is Visible
    When I see if ".wow" is visible I should get "true"

  Scenario: Is Not Visible
    When I see if ".hidden" is visible I should get "false"

  Scenario: Is Visible on a non-present element
    When I see if ".suchwow" is visible I should get "false"

  Scenario: Sending Keys to element
    When I send "doge" to an element I should be able to read "doge"

  Scenario: Sending Keys with an object
    When I send keys to an element with an object I should be able to read them

  Scenario: Adding a class
    When I add class "foo" to ".wow"
    Then ".wow" should have class "foo"

  Scenario: Adding a class with selector
    When I add class "foo" to "doge" in ".wow"
    Then "doge" should have class "foo"

  Scenario: Removing a class
    When I remove class "doge" from ".hidden"
    Then ".hidden" should not have class "doge"

  Scenario: Removing a class with selector
    When I remove class "inputbox" from "input" in "p"
    Then "input" should not have class ".inputbox"

  Scenario: Toggling a class
    When I toggle class "doge" on ".hidden"
    Then ".hidden" should not have class "doge"
    When I toggle class "doge" on ".hidden"
    Then ".hidden" should have class "doge"

  Scenario: Toggling a class with selector
    When I toggle class "such" on "doge" in ".wow"
    Then "doge" should have class "such"
    When I toggle class "such" on "doge" in ".wow"
    Then "doge" should not have class "such"

  Scenario: Has class
    When I add class "foo" to ".wow"
    Then ".wow" should contain class "foo"
    When I remove class "foo" from ".wow"
    Then ".wow" should not contain class "foo"

  Scenario: Has class
    When I add class "foo" to "doge" in ".wow"
    Then "doge" should contain class "foo" in ".wow"
    When I remove class "foo" from "doge" in ".wow"
    Then "doge" should not contain class "foo" in ".wow"

  Scenario: Hovering over a element
    Given I should be able to hover over an element

  Scenario: Doubling clicking an element
    Given I should be able to double click an element

  Scenario: Clearing an input
    Given I should be able to clear an input
