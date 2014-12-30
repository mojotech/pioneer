Driver = require('selenium-webdriver')
expect = require('chai').expect

module.exports = ->
  @When /^I execute a step$/, ->

  @Then /^the step should have a pending method$/, ->
    expect(@Pending).to.exist

  @When /^I execute a pending step$/, -> @Pending()

  @Then /^the following step should not execute$/, ->
    throw new Error "this step should not execute"

  @Then /^the environment should expose Driver$/, ->
    expect(@Driver).to.equal(Driver)