Feature: Environment

Scenario: Check for pending method
  When I execute a step
  Then the step should have a pending method

Scenario: Pending method pauses execution
  When I execute a step
  And I execute a pending step
  Then the following step should not execute

Scenario: Check for Driver
  When I execute a step
  Then the environment should expose Driver