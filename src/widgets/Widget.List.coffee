class @Widget.List extends @Widget
  itemSelector: 'li'

  itemClass: World.Widget

  at: (index) ->
    @items().then (items) ->
      items[index]

  clickAt: (index, selector) ->
    @at(index).then (widget) ->
      widget.click(selector)

  readAt: (index, selector, transformer) ->
    args = Array.prototype.slice.call(arguments, 0);

    if (_.isFunction(selector))
      args.splice(1, 0, null)

    @at(index).then (widget) =>
      widget.read.apply(widget, args.slice(1))

  map: (iter) ->
    @items().then (items) -> $.map(items, iter)

  each: (iter) ->
    @map.apply(this, arguments).then -> @items

  invoke: (method) ->
    @map (item) ->
      if _.isString(method)
        item[method]()
      else
        method.call(item)

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
