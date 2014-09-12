Feature: pending

Scenario:
  When I execute a step
  Then the step should have a pending method

Scenario:
  When I execute a step
  And I execute a pending step
  Then the following step should not execute