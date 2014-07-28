module.exports = ->
  @Given /^I should see "([^"]*)" items in a list$/, (count) ->
    new @Widgets.List().items()
    .should.eventually.have.length(count)

  @Given /^I should see "([^"]*)" in position "([^"]*)" of the list$/, (content, position) ->
    new @Widgets.List().at(+position-1)
    .then (item) -> item.find()
    .then (elm) -> elm.getText()
    .should.eventually.equal(content)

  @Given /^I should see html "([^"]*)" in position "([^"]*)" of the list$/, (content, position) ->
    new @Widgets.List().at(+position-1)
    .then (item) -> item.getHtml()
    .should.eventually.equal(content)

  @When /^I filter by "([^"]*)" I should see "([^"]*)" element$/, (string, count) ->
    new @Widgets.List().filterBy(string)
    .should.eventually.have.length(count)

  @Then /^I should see the following list:$/, (table) ->
    new @Widgets.List().toArray()
    .should.eventually.eql(_.flatten(table.raw()))

  @Then /^I should see stuff$/, (table) ->
    new @Widgets.List().toHtml()

  @When /^I find with "([^"]*)" I should see "([^"]*)"$/, (string, content) ->
    new @Widgets.List().findBy(string)
    .then (item) -> item.getHtml()
    .should.eventually.eql(content)

  @When /^I find the "([^"]*)" within "([^"]*)" I should see (\d+) items$/, (itemSelector, root, count) ->
    new @Widgets.List({
      root: root
      itemSelector: itemSelector
    }).items().should.eventually.have.length(+count)

  @When /^I find the "([^"]*)" child "([^"]*)" within "([^"]*)" and then I read the "([^"]*)" I should see "([^"]*)"$/, (index, itemSelector, root, childSelector, value) ->
    new @Widgets.List({
      root: root
      itemSelector: itemSelector
    })
    .at(+index-1)
    .then (child) ->
      child.read(childSelector).should.eventually.eql(value)

  @When /^I click on the "([^"]*)" child of "([^"]*)" I should read "([^"]*)"$/, (index, rootSelector, expected) ->
    _this = this
    new @widgets.List({
        root: rootSelector
    })
    .at(index - 1)
    .then (item) ->
      item.click()
      .then ->
        new _this.Widget({
          root: '#onSubmit'
        })
        .read()
        .should.eventually.eql(expected)
