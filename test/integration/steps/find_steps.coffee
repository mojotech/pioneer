_      = require('lodash')
expect = require("chai").expect

module.exports = ->
  @When /^I eager find the "([^"]*)" element I should see "([^"]*)"$/, (selector, content) ->
    @Widget.find({
      root: selector
    }).then (widget) ->
      widget.el.getText().should.eventually.equal(content)

  @When /^I retrieve text of the "([^"]*)" element I should get "([^"]*)"$/, (rootSelector, expected) ->
    new @Widget({
      root: rootSelector
    })
    .getText()
    .then (text) -> text.should.eql(expected)

  @When /^I retrieve text of the "([^"]*)" element as a child of "([^"]*)" I should get "([^"]*)"$/, (child, root, expected) ->
    new @Widget({
      root: root
    })
    .getText(child)
    .then (text) -> text.should.eql(expected)

  @Given /^I search for "([^"]*)" I should get "([^"]*)"$/, (search, found) ->
    new @Widget({
      root: ".wow"
    })
    .findByText(search).then( (el) ->
      el.getText()
    )
    .should.eventually.eql(found)
