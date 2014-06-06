expect = require("chai").expect

module.exports = ->
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

  @When /^I eager find the "([^"]*)" element I should see "([^"]*)"$/, (selector, content) ->
    @Widget.find({
      root: selector
    }).then (widget) ->
      widget.el.getText().should.eventually.equal(content)

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

  @When /^I see if "([^"]*)" is present within "([^"]*)" I should get "([^"]*)"$/, (child, root, isPresent) ->
    @Widget.find({
      root: root
    }).then((widget) ->
      widget.isPresent(child)
    )
    .then (present) ->
      expect(""+present).to.eql(isPresent)
