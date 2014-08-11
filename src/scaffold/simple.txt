Feature: Simple Feature

  Background:
    Given I visit TODOMVC

  Scenario: Entering Information
    When I enter "dogecoins"
    Then I should see "dogecoins"
