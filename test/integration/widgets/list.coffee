module.exports = ->
  @Widgets = @Widgets || {}

  @Widgets.List = @Widget.List.extend
    root: "ul"
    childSelector: "li"

    getItemClass: (el)->
      el.getAttribute('class').then (className) =>
        if className is 'super-hero' then @world.Widgets.ListItem else @itemClass

    clickEach: ->
      @each (item) -> item.click()

    toArray: ->
      @map (item) ->
        item.find().then (elm) -> elm.getText()

    filterBy: (string) ->
      @filter (item) ->
        item
          .find()
          .then (elm) -> elm.getText()
          .then (text) -> text.match(string) != null

    findBy: (string) ->
      @findWhere (item) ->
        item
          .find()
          .then (elm) -> elm.getText()
          .then (text) -> text.match(string) != null
