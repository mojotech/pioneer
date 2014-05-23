module.exports = ->
  @Given /^I should see "([^"]*)" items in a list$/, (count) ->
    new @Widgets.List().items()
    .should.eventually.have.length(count)

  @Given /^I should see "([^"]*)" in position "([^"]*)" of the list$/, (content, position) ->
    new @Widgets.List().items()
    .then (items) ->
      items[+position-1].find().then (elm) -> elm.getText()
    .should.eventually.equal(content)

  @Given /^I should see the following list:$/, (table) ->
    new @Widgets.List().toArray()
    .should.eventually.eql(_.flatten(table.raw()))
