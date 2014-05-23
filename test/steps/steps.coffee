Path          = require "path"
fixturesBase  = Path.resolve(__dirname, "../", "fixtures")

module.exports = ->
  @When /^I view "([^"]*)"$/, (name) ->
    @driver.get("file:///"+ Path.join(fixturesBase, name))

  @When /^I read the "([^"]*)" I should see "([^"]*)"$/, (selector, content) ->
    new @Widget({
      root: selector
    })
    .read()
    .should.eventually.eql(content)

  @When /^I find the "([^"]*)" element within "([^"]*)" I should see "([^"]*)"$/, (child, parent, content) ->
    base = new @Widget({
      root: parent
    })

    base.read(child)
    .should.eventually.eql(content)
