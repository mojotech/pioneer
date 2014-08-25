Feature: Reading from the DOM

  Background:
    When I view "sample.html"

  Scenario: Filling an input box
    When I fill an input with "wow" I should get "wow"

  Scenario: Calling Driver Visit
    When I call driver.visit
    Then the driver should get that URL
