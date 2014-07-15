Feature: Submit With
  Background:
    Given I view "form.html"

  Scenario: When I submit
    Given I enter information and submit
    Then I should see "field1 is myEmail@gmail.com and field2 is default"

  Scenario: When I fill in fields
    Given I fill a form with:
      | name    | value |
      | field1  | 1     |
      | field2  | 2     |
