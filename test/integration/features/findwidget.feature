Feature: Reading from the DOM

  Background:
    When I view "sample.html"

  Scenario: Using the find based constructor
    When I eager find the "space9" element I should see "wormhole"

  Scenario: Getting the text of an element
    When I retrieve text of the "space9" element I should get "wormhole"

  Scenario: Getting the text of an element with a child selector
    When I retrieve text of the "space9" element as a child of "deep" I should get "wormhole"

  Scenario: When I search by text
    Given I search for "many money" I should get "many money"

