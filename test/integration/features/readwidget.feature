Feature: Reading Widgets

  Background:
    When I view "sample.html"

  Scenario: Reading a flat element
    When I read the "h1" I should see "hello world"

  Scenario: Reading a flat element with a transformer
    When I read the "h1" with an all caps tranformer I should see "HELLO WORLD"

  Scenario: Reading a nested element
    When I find the "doge" element within ".wow" I should see "many money"

  Scenario: Reading attribute of element
    When I read the "width" attribute I should get "400px"

  Scenario: Getting inner HTML
    When I get the innerHTML of ".wow" I should get "<doge>many money</doge>"

  Scenario: Getting outer HTML
    When I get the outerHTML of ".wow doge" I should get "<doge>many money</doge>"
