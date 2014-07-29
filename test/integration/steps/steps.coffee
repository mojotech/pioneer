expect = require("chai").expect

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

  @Given /^The region "([^"]*)" with a ui element "([^"]*)" containing "([^"]*)"$/, (regionSelector, uiName, contents) ->
    new @Widget.View({
      regionPath: regionSelector
    }).ui(uiName)
    .then (elm) ->
      elm.getText()
      .should.eventually.eql contents

  @Given /^The app "([^"]*)" should have the region "([^"]*)" with a ui element "([^"]*)" containing "([^"]*)"$/, (appPath, regionSelector, uiName, contents) ->
    new @Widget.View({
      regionPath: regionSelector
      appPath: appPath
    }).ui(uiName)
    .then (elm) ->
      elm.getText()
      .should.eventually.eql contents

  @Given /^a widget\.view without a regionName should fail$/, ->
    expect(@Widget.View).to.throw("A Widget.View requires regionPath")

  @Given /^a widget\.view ui lookup without a selector should fail$/, ->
    widget = new @Widget.View({
      regionPath: "wow"
    })

    expect(-> widget.ui()).to.throw("A UI selector is required")

  @When /^I see if "([^"]*)" is present within "([^"]*)" I should get "([^"]*)"$/, (child, root, isPresent) ->
    @Widget.find({
      root: root
    }).then((widget) ->
      widget.isPresent(child)
    )
    .then (present) ->
      expect(""+present).to.eql(isPresent)

  @When /^I read the "([^"]*)" with an all caps tranformer I should see "([^"]*)"$/, (selector, content) ->
    allCaps = (str) -> str.toUpperCase()
    new @Widget({
      root: selector
    })
    .read(null, allCaps)
    .should.eventually.eql(content)

  @Given /^I search for "([^"]*)" I should get "([^"]*)"$/, (search, found) ->
    new @Widget({
      root: ".wow"
    })
    .findByText(search).then( (el) ->
      el.getText()
    )
    .should.eventually.eql(found)

  @When /^I see if "([^"]*)" is visible I should get "([^"]*)"$/, (selector,found) ->
    new @Widget({
      root: selector
    })
    .isVisible()
    .then (isFound) -> (isFound+"").should.eql(found)

  @When /^I read the "([^"]*)" attribute I should get "([^"]*)"$/, (attribute, expected) ->
    new @Widget({
      root: ".wow"
    })
    .getAttribute(attribute)
    .then (attr) -> attr.should.eql(expected)

  @When /^I retrieve text of the "([^"]*)" element I should get "([^"]*)"$/, (rootSelector, expected) ->
    new @Widget({
      root: rootSelector
    })
    .getText()
    .then (text) -> text.should.eql(expected)

  @When /^I retrieve text of the "([^"]*)" element as a child of "([^"]*)" I should get "([^"]*)"$/, (child, root, expected) ->
    new @Widget({
      root: root
    })
    .getText(child)
    .then (text) -> text.should.eql(expected)

  @When /^I send "([^"]*)" to an element I should be able to read "([^"]*)"$/, (sent, read) ->
    w = new @Widget({
      root: ".inputbox"
    })

    w.sendKeys(sent)
    .then ->
      w.read().should.eventually.eql(read)

  @When /^I fill an input with "([^"]*)" I should get "([^"]*)"$/, (write, read) ->
    w = new @Widget({
      root: '.inputbox'
    })

    w.fill(write)
    .then ->
      w.read().should.eventually.eql(read)

  @When /^I get the innerHTML of "([^"]*)" I should get "([^"]*)"$/, (rootSelector, expected) ->
    new @Widget({
      root: rootSelector
    })
    .getInnerHTML().then (html) ->
      html.trim().should.eql(expected)

  @When /^I get the outerHTML of "([^"]*)" I should get "([^"]*)"$/, (rootSelector, expected) ->
    new @Widget({
      root: rootSelector
    })
    .getOuterHTML().then (html) ->
      html.split('\n').map((string) ->
        string.trim()
      )
      .join("").should.eql(expected)

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
