_      = require('lodash')
expect = require("chai").expect

module.exports = ->
  @When /^I fill an input with "([^"]*)" I should get "([^"]*)"$/, (write, read) ->
    new @Widget({
      root: '.inputbox'
    }).fill(write)
    .then =>
      @W.getValue({selector: ".inputbox"}).should.eventually.eql(read)

  @When /^I fill an input with nothing I should get an error$/, ->
    expect( =>
      new @Widget({root: '.inputbox'})
      .fill()
    )
    .to.throw("You must pass a value to fill with. https://github.com/mojotech/pioneer/blob/master/docs/widget.md#fill")
