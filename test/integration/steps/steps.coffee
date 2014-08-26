_      = require('lodash')
expect = require("chai").expect

module.exports = ->
  @When /^I fill an input with "([^"]*)" I should get "([^"]*)"$/, (write, read) ->
    w = new @Widget({
      root: '.inputbox'
    })

    w.fill(write)
    .then ->
      w.getValue().should.eventually.eql(read)

  @Given /^I should be able to hover over an element$/, ->
    new @W({
      root: 'h4'
    })
    .hover()
    .then (w) ->
      w.read()
      .should.eventually
      .eql("ok ok only on hover")

  @Given /^I should be able to double click an element$/, ->
    new @W({
      root: '.double'
    })
    .doubleClick()
    .then (w) ->
      w.read()
      .should.eventually
      .eql("wow such click")

  @Given /^I should be able to clear an input$/, ->
    w = new @W({
      root: ".inputbox"
    })
    w.sendKeys("filled with this").then =>
      w.clear().then (widget) ->
        widget.getValue().should.eventually.eql("")
