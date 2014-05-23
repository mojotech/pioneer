module.exports = ->
  @Widgets = @Widgets || {}

  @Widgets.List = @Widget.List.extend
    root: "ul"
    childSelector: "li"

    toArray: ->
      @items().then (items) ->
        $.map items, (item) ->
          item.find().then (elm) -> elm.getText()
