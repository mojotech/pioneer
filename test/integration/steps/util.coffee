Path          = require "path"
fixturesBase  = Path.resolve(__dirname, "../", "fixtures")

module.exports = ->
  @When /^I view "([^"]*)"$/, (name) ->
    @driver.get("file:///"+ Path.join(fixturesBase, name))

