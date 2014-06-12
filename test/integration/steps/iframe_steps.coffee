module.exports = ->
  @When /^I switch to the iframe "([^"]*)" I should see the content "([^"]*)"$/, (iframe, content)->
    new @Widgets.Myframe({
      root: iframe
    }).focus()
    .then (w) -> w.getParentText('p')
    .should.eventually.eql(content)

  @When /^I unfocus from the iframe "([^"]*)" I should see "([^"]*)"$/, (iframe, content) ->
    new @Widgets.Myframe({
      root: iframe
    }).unfocus()
    .then (w) -> w.getParentText('p')
    .should.eventually.eql(content)
