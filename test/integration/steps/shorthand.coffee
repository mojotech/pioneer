_ = require('lodash')

module.exports = ->

  @When /^I shorthand double click an element$/, ->
    @W.doubleClick({
      selector: '.double'
    }).then (w) -> w.read({selector: ".double"}).should.eventually.eql("wow such click")

  @When /^I shorthand hover an element$/, ->
    @W.hover({
      selector: "h4"
    }).then (w) ->
      w.read({selector: "h4"}).should.eventually.eql("ok ok only on hover")

  @When /^I shorthand click an element$/, ->
    @W.click({selector: 'body'})

  @When /^I shorthand fill an element$/, ->
    @W.fill({
      selector: ".inputbox",
      value: "wow"
    })

  @When /^I shorthand isPresent an element$/, ->
    @W.isPresent(".wow doge").should.eventually.eql(true)

  @When /^I shorthand isVisible an element$/, ->
    @W.isVisible({
      selector: ".wow"
    }).should.eventually.eql(true)

  @When /^I shorthand getAttribute an element$/, ->
    @W.getAttribute({
      attribute: "width",
      selector: ".wow"
    }).should.eventually.eql("400px")

  @When /^I shorthand getValue the element$/, ->
    @W.getValue({
      selector: ".inputbox"
    }).should.eventually.eql("wow")

  @When /^I shorthand getText an element$/, ->
    @W.getText({
      selector: "h1"
    }).should.eventually.eql("hello world")

  @When /^I shorthand getInnerHTML an element$/, ->
    @W.getInnerHTML({
      selector: ".wow"
    }).then (html) ->
      html.trim()
      .should.eql("<doge>many money</doge>")

  @When /^I shorthand getOuterHTML an element$/, ->
    @W.getOuterHTML({
      selector: ".wow doge"
    }).then (html) ->
      html.split('\n').map((string) ->
        string.trim()
      )
      .join("")
      .should.eql("<doge>many money</doge>")

  @When /^I shorthand call hasClass an element$/, ->
    @W.hasClass({
      selector: ".hidden",
      className: "doge"
    }).should.eventually.be.true

  @When /^I shorthand call sendKeys an element$/, ->
    @W.sendKeys({
      selector: ".inputbox",
      keys: [
        "dogecoins",
        Driver.Key.SPACE,
        "are",
        Driver.Key.SPACE,
        "worth",
        Driver.Key.SPACE,
        "alot"
      ]
    }).then =>
      @getValue({
        selector: ".inputbox"
      }).should.eventually.eql("dogecoins are worth alot")

  @When /^I shorthand call clear an element$/, ->
    new @W({
      root: ".inputbox"
    }).sendKeys("pioneer is awesome man...").then =>
      @W.clear({
        selector: ".inputbox"
      }).then (widget) ->
        widget.getValue({selector: ".inputbox"})
        .should.eventually.eql("")
