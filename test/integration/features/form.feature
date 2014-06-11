Feature: Submit With
  Background:
    Given I view "form.html"

  Scenario: When I submit
    Given I enter information and submit
    Then I should see "field1 is myEmail@gmail.com and field2 is default"
