module.exports = ->
  this.Widgets = this.Widgets || {}

  return this.Widgets.Div = this.Widget.extend
    root: "#onSubmit"

    getText: ->
      @find().then (el) -> el.getText()
