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
