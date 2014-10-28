module.exports = ->
  this.Widgets = this.Widgets || {}

  return this.Widgets.ListItem = this.Widget.extend

    getIdentity: ->
      @getText().then (val) ->
        'Iron Man' if val is 'Tony Stark'
