Feature: Marionette Views

  Background:
    Given I view "marionette.html"

  Scenario: Defining a View without a region name
    Given a widget.view without a regionName should fail

  Scenario: Getting a ui element without a selector
    Given a widget.view ui lookup without a selector should fail

  Scenario: Getting an item from a views UI hash without an application
    Given The region "MyRegion" with a ui element "borg" containing "the borg"

  Scenario: Getting an item from a views UI hash within an application
    Given The app "window" should have the region "MyRegion" with a ui element "assimilate" containing "like to eat cheerios"
