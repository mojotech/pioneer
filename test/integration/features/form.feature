Feature: Submit With
  Background:
    Given I view "form.html"

  Scenario: Clicking Submit
    Given I click submit
    Then I should see "field1 is and field2 is default"

  Scenario: When I submit
    Given I enter information and submit
    Then I should see "field1 is myEmail@gmail.com and field2 is default"

  Scenario: Clearing an input before filling
    Given I fill the field with default with something else
    Then I should only see something else

  Scenario: When I fill in fields
    Given I fill a form with:
      | name    | value |
      | field1  | 1     |
      | field2  | 2     |

  Scenario: When I instantiate a form widget without a root selector
    Then the widget should use the default form selector to find the first available form element

  Scenario: When I instantiate a form widget with a root selector
    Then the widget should find the form with the supplied selector of "#form"

  Scenario: When I search for a nested option
    When I search for a nested option I should find it

  Scenario: When I select by value
    When I select an option by value

  Scenario: When I select by text
    When I select an option by text

  Scenario: Selecting with no selector
    When I try to select with no selector

  Scenario: Selecting with both selectors
    When I try to select with both selectors

  Scenario: Reading all fields of a form
    When I read all fields of a form I should see the results
