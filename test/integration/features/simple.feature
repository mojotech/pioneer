Feature: Reading from the DOM

  Background:
    When I view "sample.html"

  Scenario: Reading a flat element
    When I read the "h1" I should see "hello world"

  Scenario: Reading a nested element
    When I find the "doge" element within ".wow" I should see "many money"

  Scenario: Using the find based constructor
    When I eager find the "space9" element I should see "wormhole"
