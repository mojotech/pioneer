Feature: Manipulating Lists

  Background:
    Given I view "list.html"

  Scenario: Getting items in a list
    Then I should see "6" items in a list

  Scenario: Getting itemClass dynamically
    Then I should get the alias "Iron Man" for the item with a super-hero class

  Scenario: Getting an item in a list
    Then I should see "geordi laforge" in position "4" of the list
    Then I should see html "<li>geordi laforge</li>" in position "4" of the list

  Scenario: Serializing items in a list
    Then I should see the following list:
      | data            |
      | 7 of nine       |
      | deanna troi     |
      | geordi laforge  |
      | John Crichton   |
      | Tony Stark      |

  Scenario: Filtering items in a list
    When I filter by "John" I should see "1" element

  Scenario: Finding the first matching element in a list
    When I find with "a" I should see "<li>data</li>"

  Scenario: Calling AT with a string
    When I call at with a string I should get an error

  Scenario: Getting length of a list
    When I call length I should receive 6

  Scenario: Nested list lookup
    When I find the "span" within ".nested" I should see 3 items

  Scenario: Nested list lookup with additonal child lookup
    When I find the "3" child "span" within ".nested" and then I read the "p" I should see "protoss"

  Scenario: Reading at an index
    When I read at the "2" index of ul I should see "7 of nine"

  Scenario: Reading at an index with a transformer
    Given I should be able to read and transform a list item at an index

  Scenario: Reading at an index with a transformer and selector
    Given I should be able to read with a subselector and transform an item at an index

  Scenario: Reading at an index with selector
    When I read at the "2" child "span" within ".nested" inside "p" I should see "human"

  Scenario: Clicking on an index
    When I click on the "3" child of "ul" I should read "clicked"

  Scenario: Clicking at an index
    When I click at the "3" index of "ul" I should read "clicked"

  Scenario: Clicking at an index with selector
    When I click at the "5" index with selector "p" I should read "clicked"

  Scenario: Looping over items in a list with each
    When I click on each item in the list
    Then I should see that each list item was clicked

  Scenario: Invoking a method over the list with a string
    Given I can invoke click on each widget in the list
    Then I should see that each list item was clicked

  Scenario: Invoking a method over the list with a method
    Given I can invoke click on each widget in the list with a method
    Then I should see that each list item was clicked

  Scenario: Invoking a method over the list with arguments
    Given I can invoke read on each widget in the list with a transformer and selector

  Scenario: Visiblity on list items
    Given I can check the visibility on a list's items
