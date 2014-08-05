expect = require("chai").expect

module.exports = ->
  @Given /^The region "([^"]*)" with a ui element "([^"]*)" containing "([^"]*)"$/, (regionSelector, uiName, contents) ->
    new @Widget.View({
      regionPath: regionSelector
    }).ui(uiName)
    .then (elm) ->
      elm.getText()
      .should.eventually.eql contents

  @Given /^The app "([^"]*)" should have the region "([^"]*)" with a ui element "([^"]*)" containing "([^"]*)"$/, (appPath, regionSelector, uiName, contents) ->
    new @Widget.View({
      regionPath: regionSelector
      appPath: appPath
    }).ui(uiName)
    .then (elm) ->
      elm.getText()
      .should.eventually.eql contents

  @Given /^a widget\.view without a regionName should fail$/, ->
    expect(@Widget.View).to.throw("A Widget.View requires regionPath")

  @Given /^a widget\.view ui lookup without a selector should fail$/, ->
    widget = new @Widget.View({
      regionPath: "wow"
    })

    expect(-> widget.ui()).to.throw("A UI selector is required")

  @When /^I fill an input with "([^"]*)" I should get "([^"]*)"$/, (write, read) ->
    w = new @Widget({
      root: '.inputbox'
    })

    w.fill(write)
    .then ->
      w.getValue().should.eventually.eql(read)
