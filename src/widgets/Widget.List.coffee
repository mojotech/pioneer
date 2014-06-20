class @Widget.List extends @Widget
  itemSelector: 'li'

  itemClass: World.Widget

  at: (index) ->
    @items().then (items) ->
      items[index]

  map: (iter) ->
    @items().then (items) -> $.map(items, iter)

  filter: (iter) ->
    @items().then (items) -> $.filter(items, iter)

  items: ->
    @findAll(@itemSelector).then (items) =>
      _.map items, (item, i) =>
        sel = "#{@root} #{@itemSelector}:nth-child(#{i + 1})"
        new @itemClass(root: sel)

  findWhere: (iter) ->
    @filter(iter).then (items) -> items[0] if items

