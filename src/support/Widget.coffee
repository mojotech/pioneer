module.exports = ->
  World    = @
  @Widgets = {}

  class @Widget

    constructor: (attributes = {}) ->
      _.extend @, attributes

    world: World

    # use a getter to lazily initialize driver
    @getter 'driver', ->
      @_driver || World.driver

    click: (selector) ->
      @find(selector).click()

    fill: (selector, value) ->
      @find(selector).sendKeys(value)

    read: (selector) ->
      selected = @find(selector)
      selected.getAttribute('value').then (value) ->
        value or selected.getText()

    find: (selector) ->
      _selector  = Driver.By.css(@_selector(selector))
      _isPresent = =>
        @driver.isElementPresent(_selector)

      @driver.wait(_isPresent, 10000, "#{_selector} not found")
      @driver.findElement(_selector)

    isPresent: ->
      @driver.isElementPresent(Driver.By.css(@root))

    findAll: (selector) ->
      @driver.findElements(Driver.By.css(@_selector(selector)))

    _selector: (selector) ->
      @root + (if selector then " #{selector}" else '')

    _map: (collection, callback) ->
      results = []
      _reduce = (p, f, i) ->
        p.then ->
          callback(f, i).then (v) -> results.push(v)
      _.reduce(collection, _reduce, Driver.promise.fulfilled())
        .then -> results

  class @Widget.Fields extends @Widget
    fillAll: (values) ->
      @_map @fields, (f) => @fill(@_name(f), values[f])

    readAll: ->
      _readAll = (f) =>
        @read(@_name(f)).then (v) -> [f, v]

      @_map(@fields, _readAll).then (read) ->
        _.object(read)

    _name: (name) ->
      "[name='#{name}']"

    _type: (type) ->
      "[type='#{type}']"

  class @Widget.Form extends @Widget.Fields
    submitSelector: ->
      @_type('submit')

    submitWith: (values) =>
      @fillAll(values)
      @click @submitSelector()

  class @Widget.List extends @Widget
    itemSelector: 'li'
    itemClass: World.Widget

    items: ->
      @findAll(@itemSelector).then (items) =>
        _.map items, (item, i) =>
          sel = "#{@root} #{@itemSelector}:nth-child(#{i + 1})"
          new @itemClass(root: sel)
