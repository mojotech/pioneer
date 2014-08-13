expect = require("chai").expect

module.exports = ->
  @When /^I read the "([^"]*)" I should see "([^"]*)"$/, (selector, content) ->
    new @Widget({
      root: selector
    })
    .read()
    .should.eventually.eql(content)

  @When /^I read the "([^"]*)" with an all caps tranformer I should see "([^"]*)"$/, (selector, content) ->
    new @Widget({
      root: selector
    })
    .read({
      transformer: (str) -> str.toUpperCase()
    })
    .should.eventually.eql(content)

  @When /^I find the "([^"]*)" element within "([^"]*)" I should see "([^"]*)"$/, (child, parent, content) ->
    base = new @Widget({
      root: parent
    })

    base.read(child)
    .should.eventually.eql(content)

  @When /^I read the "([^"]*)" attribute I should get "([^"]*)"$/, (attribute, expected) ->
    new @Widget({
      root: ".wow"
    })
    .getAttribute(attribute)
    .then (attr) -> attr.should.eql(expected)

  @When /^I read the "([^"]*)" attribute of a nested element I should get "([^"]*)"$/, (attr, expected) ->
    new @Widget({
      root:".container"
    }).getAttribute({
      selector: ".nested",
      attribute: attr
    }).then (val) -> val.should.eql(expected)

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
