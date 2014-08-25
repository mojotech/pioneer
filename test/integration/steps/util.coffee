_             = require('lodash')
Path          = require "path"
fixturesBase  = Path.resolve(__dirname, "../", "fixtures")

module.exports = ->
  @When /^I view "([^"]*)"$/, (name) ->
    @driver.get("file:///"+ Path.join(fixturesBase, name))

  @When /^I call driver.visit$/, ->
    @driver.visit("http://www.google.com/")

  @Then /^the driver should get that URL$/, ->
    @driver.getCurrentUrl()
    .should.eventually.eql("http://www.google.com/")
