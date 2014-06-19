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

  read: (selector, transformer) ->
    transformer ||= (value) -> value
    selected = @find(selector)
    selected.getAttribute('value').then (value) ->
      if value
        return transformer(value)
      else
        return selected.getText().then transformer

  find: (selector) ->
    @driver.wait(
      _.bind(@isPresent, this, selector), 
      10000, 
      "#{@_selector(selector)} not found"
    )

    @driver.findElement(Driver.By.css(@_selector(selector)))

  getHtml: (selector) ->
     @find(selector).getOuterHtml()

  isPresent: (selector) ->
    @driver.isElementPresent(Driver.By.css(@_selector(selector)))

  isVisible: (selector) ->
    @find(selector).then (elm) ->
      elm.isDisplayed()

  findAll: (selector) ->
    @driver.findElements(Driver.By.css(@_selector(selector)))

  _selector: (selector) ->
    @root + (if selector then " #{selector}" else '')

  findByText: (text) ->
    @driver.findElement(Driver.By.xpath('//*[normalize-space(text())=normalize-space("' + text + '")]'))

  _map: (collection, callback) ->
    results = []
    _reduce = (p, f, i) ->
      p.then ->
        callback(f, i).then (v) -> results.push(v)
    _.reduce(collection, _reduce, Driver.promise.fulfilled())
      .then -> results
