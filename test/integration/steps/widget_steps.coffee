expect = require("chai").expect

module.exports = ->
  @When /^I see if "([^"]*)" is present within "([^"]*)" I should get "([^"]*)"$/, (child, root, isPresent) ->
    @Widget.find({
      root: root
    }).then((widget) ->
      widget.isPresent(child)
    )
    .then (present) ->
      expect(""+present).to.eql(isPresent)

  @When /^I see if "([^"]*)" is visible I should get "([^"]*)"$/, (selector,found) ->
    new @Widget({
      root: selector
    })
    .isVisible()
    .then (isFound) -> (isFound+"").should.eql(found)

  @When /^I send "([^"]*)" to an element I should be able to read "([^"]*)"$/, (sent, read) ->
    w = new @Widget({
      root: ".inputbox"
    })

    w.sendKeys(sent)
    .then ->
      w.getValue().should.eventually.eql(read)

  @When /^I add class "([^"]*)" to "([^"]*)"$/, (className, selector) ->
    new @Widget({
      root: selector
    })
    .addClass(className)

  @Then /^"([^"]*)" should have class "([^"]*)"$/, (selector, expected) ->
    new @Widget({
      root: selector
    })
    .getAttribute('class')
    .then (attribute) ->
      attribute.indexOf(expected).should.not.eql(-1)

  @When /^I remove class "([^"]*)" from "([^"]*)"$/, (className, selector) ->
    new @Widget({
      root: selector
    })
    .removeClass(className)

  @Then /^"([^"]*)" should not have class "([^"]*)"$/, (selector, expected) ->
    new @Widget({
      root: selector
    })
    .getAttribute('class')
    .then (attribute) ->
      attribute.indexOf(expected).should.eql(-1)

  @When /^I toggle class "([^"]*)" on "([^"]*)"$/, (className, selector) ->
    new @Widget({
      root: selector
    })
    .toggleClass(className)
