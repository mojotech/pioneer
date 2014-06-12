Feature: Iframe

  Background:
    Given I view "iframe.html"

  Scenario: Getting text from iframe
    When I switch to the iframe "iframe" I should see the content "Welcome to the other side"
    When I unfocus from the iframe "iframe" I should see "Is the grass really greener?"
