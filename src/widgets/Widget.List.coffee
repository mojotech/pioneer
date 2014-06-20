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
    @find().then (el) =>
      el.findElements(Driver.By.css(@itemSelector))
    .then (elms) =>
      _.map elms, (el) =>
        new @itemClass({
          el: el
        })

  findWhere: (iter) ->
    @filter(iter).then (items) -> items[0] if items

