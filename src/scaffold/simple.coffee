module.exports = ->
  @Given /^I visit TODOMVC$/, ->
    @driver.get('http://todomvc.com/examples/backbone/')

  When /^I enter \"([^\"]*)\"$/, (value) ->
    new @Widget
      root: "#new-todo"
    .sendKeys(value,'\uE007')

  @Then /^I should see \"([^\"]*)\"$/, (expected) ->
    class List extends @Widget.List
      root: "#todo-list"
      childSelector: "li"
    new List().readAt(0).should.eventually.eql(expected)
