class @Widget
  @extend: (protoProps, staticProps) ->
    parent = @
    if Object.hasOwnProperty(protoProps, 'constructor')
      child = protoProps.constructor
    else
      child = -> parent.apply(@, arguments)

    child.copyProperties @
    child.copyProperties staticProps

    Surrogate = ->
      @constructor = child
      return undefined

    Surrogate.prototype = @::
    child.prototype = new Surrogate()

    child::.copyProperties(protoProps) if protoProps

    child.__super__ = @::

    child

  @find = (attributes) ->
    _this = _.extend(new this, attributes)

    _this.find().then (el) ->
      _this.el = el
      _this

  constructor: (attributes = {}) ->
    _.extend @, attributes

    @initialize.apply @, arguments

  # Defines a noop initialize method intended to be
  # overridden by the user when extending a Widget base class
  initialize: ->

  world: World

  # use a getter to lazily initialize driver
  @getter 'driver', ->
    @_driver || World.driver

  click: (selector) ->
    @find(selector).click()

  fill: (selector, value) ->
    el = @find(selector)
    el.clear().then ->
      el.sendKeys(value)

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

  getHtml: (selector) ->
     @find(selector).getOuterHtml()

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
