_      = require('lodash')
expect = require('chai').expect

module.exports = ->
  world = this

  @Given /^I click submit$/, ->
    new this.Widgets.SimpleForm().submitForm()

  @Given /^I fill the field with default with something else$/, ->
    new @Widget({
      root: "#field2"
    })
    .fill({value: "doge"})

  @Then /^I should only see something else$/, ->
    new @Widget({
      root: "#field2"
    })
    .getValue()
    .should.eventually.eql("doge")

  @Given /^I enter information and submit$/, ->
    form = new this.Widgets.SimpleForm()
    form.enter()

  @Then /^I should see "([^"]*)"$/, (text) ->
    div = new this.Widgets.Div()
    div.getText().should.eventually.eql(text)

  @Given /^I fill a form with:$/, (table) ->
    F = world.Widget.Form.extend({
     root: 'form'
     fields: _.map(table.hashes(), "name")
    })

    new F().submitWith(_.fromPairs(table.raw().slice(1)))

  @Then /^the widget should use the default form selector to find the first available form element$/, ->
    new @Widget.Form().getAttribute("class").should.eventually.eql("formula_1")

  @Then /^the widget should find the form with the supplied selector of "([^"]*)"$/,  (selector) ->
    new @Widget.Form({root: selector}).getAttribute("id").should.eventually.eql("form")

  @When /^I search for a nested option I should find it$/, ->
    new @Widget({
      root: "select"
    }).find("[value=\"wow3\"]").then (el) ->
      el.getText().then (val) ->
        val.should.eql("three")

  @When /^I select an option by value$/, ->
    _this = this
    new @Widget.Form({
      root: "select"
    })
    .select({value:"wow2"}).then ->
      new _this.Widget({
        root: '#onClick'
      })
      .read()
      .should.eventually.eql('two')

  @When /^I select an option by text$/, ->
    _this = this
    new @Widget.Form({
      root: "select"
    })
    .select({text:"three"})
    .then ->
      new _this.Widget({
        root: '#onClick'
      })
      .read()
      .should.eventually.eql('three')


  @When /^I try to select with no selector$/, ->
    expect( =>
      new @Widget.Form({
        root: "select"
      })
      .select()
    ).to.throw("You must provide something to select by.")

  @When /^I try to select with both selectors$/, ->
    expect( =>
      new @Widget.Form({
        root: "select"
      })
      .select({ text: "three", value: "wow3"})
    ).to.throw("You may only have one select by attribute")

  @When /^I read all fields of a form I should see the results$/, ->
    f = new @Widgets.SimpleForm()
    f.submitWith({
      field1: "wow",
      field2: "such"
    }).then ->
      f.readAll().should.eventually.eql({
        field1: "wow",
        field2: "such"
      })

  @When /^I click a checkbox$/, ->
    @W.click('input[type="checkbox"]')

  @Then /^the checkbox should be selected$/, ->
    @W.find({root: 'input[type="checkbox"]'})
    .then (widget) -> widget.el.isSelected()
    .should.eventually.eql(true)
