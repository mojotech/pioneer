Feature: Reading from the DOM

  Background:
    When I view "sample.html"

  Scenario: Reading a flat element
    When I read the "h1" I should see "hello world"

  Scenario: Reading a flat element with a transformer
    When I read the "h1" with an all caps tranformer I should see "HELLO WORLD"

  Scenario: Reading a nested element
    When I find the "doge" element within ".wow" I should see "many money"

  Scenario: Using the find based constructor
    When I eager find the "space9" element I should see "wormhole"

  Scenario: Getting the text of an element
    When I retrieve text of the "space9" element I should get "wormhole"

  Scenario: Getting the text of an element with a child selector
    When I retrieve text of the "space9" element as a child of "deep" I should get "wormhole"

  Scenario: Is Present
    When I see if "doge" is present within ".wow" I should get "true"

  Scenario: Is Not Present
    When I see if "dogey" is present within ".wow" I should get "false"

  Scenario: When I search by text
    Given I search for "many money" I should get "many money"

  Scenario: Is Visible
    When I see if ".wow" is visible I should get "true"

  Scenario: Is Not Visible
    When I see if ".hidden" is visible I should get "false"

  Scenario: Reading attribute of element
    When I read the "width" attribute I should get "400px"

  Scenario: Sending Keys to element
    When I send "doge" to an element I should be able to read "doge"

  Scenario: Filling an input box
    When I fill an input with "wow" I should get "wow"

  Scenario: Getting inner HTML
    When I get the innerHTML of ".wow" I should get "<doge>many money</doge>"

  Scenario: Getting outer HTML
    When I get the outerHTML of ".wow doge" I should get "<doge>many money</doge>"

  Scenario: Adding a class
    When I add class "foo" to ".wow"
    Then ".wow" should have class "foo"

  Scenario: Removing a class
    When I remove class "doge" from ".hidden"
    Then ".hidden" should not have class "doge"

  Scenario: Toggling a class
    When I toggle class "doge" on ".hidden"
    Then ".hidden" should not have class "doge"
    When I toggle class "doge" on ".hidden"
    Then ".hidden" should have class "doge"
