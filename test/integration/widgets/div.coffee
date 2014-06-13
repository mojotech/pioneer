module.exports = ->
  this.Widgets = this.Widgets || {}

  return this.Widgets.Div = this.Widget.extend
    root: "#onSubmit"

    getText: ->
      @find().getText();
