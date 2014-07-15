module.exports = ->
  this.Widgets = this.Widgets || {}

  return this.Widgets.SimpleForm = this.Widget.Form.extend
    root: '#form',
    fields: ["field1", "field2"]

    enter: ->
      @submitWith({field1: "myEmail@gmail.com"})
