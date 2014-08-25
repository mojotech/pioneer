_      = require('lodash')
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

  @When /^I add class "([^"]*)" to "([^"]*)" in "([^"]*)"$/, (className, childSelector, selector) ->
    new @Widget({
      root: selector
    })
    .addClass({
      selector: childSelector,
      className: className
    })

  @When /^I remove class "([^"]*)" from "([^"]*)" in "([^"]*)"$/, (className, childSelector, selector) ->
    new @Widget({
      root: selector
    })
    .removeClass({
      className: className,
      selector: childSelector
    })

  @When /^I toggle class "([^"]*)" on "([^"]*)" in "([^"]*)"$/, (className, childSelector, selector) ->
    new @Widget({
      root: selector
    })
    .toggleClass({
      className: className,
      selector: childSelector
    })

  @Then /^"([^"]*)" should contain class "([^"]*)"$/, (selector, className) =>
    widget = new @Widget({
      root: selector
    })
    .hasClass(className).should.eventually.be.true

  @Then /^"([^"]*)" should not contain class "([^"]*)"$/, (selector, className) =>
    new @Widget({
      root: selector
    })
    .hasClass(className).should.eventually.be.false

  @Then /^"([^"]*)" should contain class "([^"]*)" in "([^"]*)"$/, (childSelector, className, selector) =>
    widget = new @Widget({
      root: selector
    })
    .hasClass({
      className: className
      selector: childSelector
    }).should.eventually.be.true

  @Then /^"([^"]*)" should not contain class "([^"]*)" in "([^"]*)"$/, (childSelector, className, selector) =>
    widget = new @Widget({
      root: selector
    })
    .hasClass({
      className: className
      selector: childSelector
    }).should.eventually.be.false
