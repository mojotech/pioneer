Feature: Reading from the DOM

  Background:
    When I view "sample.html"

  Scenario: Filling an input box
    When I fill an input with "wow" I should get "wow"

  Scenario: Filling an input box with something invalid
    When I fill an input with nothing I should get an error

  Scenario: Calling Driver Visit
    When I call driver.visit
    Then the driver should get that URL
