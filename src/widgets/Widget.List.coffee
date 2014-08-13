_ = require("lodash")

class @Widget.List extends @Widget
  itemSelector: 'li'

  itemClass: World.Widget

  at: (opts) ->
    if _.isNumber(opts)
      @items().then (items) ->
        items[opts]
    else
      throw new Error("Argument must be a number. https://github.com/mojotech/pioneer/blob/master/docs/list.md#at")

  clickAt: (opts) ->
    if _.isNumber(opts)
      opts = {index: opts}
    @at(opts.index).then (widget) ->
      widget.click(opts.selector)

  readAt: (opts) ->
    if (_.isNumber(opts))
      return @at(opts).then (widget) -> widget.read()
    else
      @at(opts.index).then (widget) -> widget.read(opts)

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
