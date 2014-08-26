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
