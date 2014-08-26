Feature: Shorthand Widget Methods

  Background:
    When I view "sample.html"

  Scenario: Click
    When I shorthand click an element

  Scenario: Fill
    When I shorthand fill an element
    Then I shorthand getValue the element

  Scenario: Hover
    When I shorthand hover an element

  Scenario: Double Click
    When I shorthand double click an element

  Scenario: isPresent
    When I shorthand isPresent an element

  Scenario: isVisible
    When I shorthand isVisible an element

  Scenario: getAttribute
    When I shorthand getAttribute an element

  Scenario: getText
    When I shorthand getText an element

  Scenario: getInnerHTML
    When I shorthand getInnerHTML an element

  Scenario: getOuterHTML
    When I shorthand getOuterHTML an element

  Scenario: hasClass
    When I shorthand call hasClass an element

  Scenario: sendKeys
    When I shorthand call hasClass an element

  Scenario: clear
    When I shorthand call clear an element
