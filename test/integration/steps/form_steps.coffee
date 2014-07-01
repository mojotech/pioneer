module.exports = ->
  world = this

  @Given /^I enter information and submit$/, ->
    form = new this.Widgets.SimpleForm()
    form.enter()

  @Then /^I should see "([^"]*)"$/, (text) ->
    div = new this.Widgets.Div()
    div.getText().should.eventually.eql(text)

  @Given /^I fill a form with:$/, (table) ->
    F = world.Widget.Form.extend({
     root: 'form'
     fields: _.pluck(table.hashes(), "name")
    })

    new F().submitWith(_.object(table.raw().slice(1)))
