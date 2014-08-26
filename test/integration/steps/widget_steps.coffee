_      = require('lodash')
expect = require("chai").expect
Driver = require('selenium-webdriver')

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

  @When /^I make sure inputbox is empty$/, ->
    new @Widget({root: ".inputbox"}).then (w) =>
      w.find().then (el) -> el.clear()

  @Then /^I send keys to an element with an object I should be able to read them$/, ->
    w = new @Widget({
      root: "p"
    })
    w.sendKeys({
      selector: ".inputbox",
      keys: [
        "wow",
        Driver.Key.SPACE,
        "such",
        Driver.Key.SPACE,
        "send",
        Driver.Key.SPACE,
        "keys"
      ]
    }).then ->
      w.getValue({selector: ".inputbox"})
      .should.eventually.eql("wow such send keys")

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
