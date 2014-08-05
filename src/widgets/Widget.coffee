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
    @find(selector).then (el) ->
      el.click()

  fill: ->
    args = arguments
    if (args.length > 1)
      @find(args[0]).then (el) ->
        el.clear().then ->
          el.sendKeys(args[1])
    else
     @find().then (el) ->
      el.sendKeys(args[0])

  read: (selector, transformer) ->
    transformer ||= (value) -> value
    @find(selector).then (el) ->
      return el.getText().then transformer

  getValue: (selector, transformer) ->
    transformer ||= (value) -> value
    @find(selector).then (el) ->
      el.getAttribute('value').then (value) ->
        return transformer(value)

  find: (selector) ->
    deferred = new $.Deferred

    if (@el)
      if !selector
        deferred.fulfill(@el)
      else
        return @el.findElement(Driver.By.css(selector))

      return deferred

    @_ensureElement(selector)
    @driver.findElement(Driver.By.css(@_selector(selector)))

  getHtml: (selector) ->
     @find(selector).then (el) -> el.getOuterHtml()

  getText: (selector) ->
    @find(selector).then (el) -> el.getText()

  getAttribute: (attribute) ->
    @find().then (el) ->
      el.getAttribute(attribute)

  getInnerHTML: (selector) ->
    @find(selector).then (el) -> el.getInnerHtml()

  getOuterHTML: (selector) ->
    @find(selector).then (el) -> el.getOuterHtml()

  isPresent: (selector) ->
    @driver.isElementPresent(Driver.By.css(@_selector(selector)))

  isVisible: (selector) ->
    @find(selector).then (elm) ->
      elm.isDisplayed()

  addClass: (className) ->
    @find().then (el) =>
      @driver.executeScript("arguments[0].classList.add(arguments[1])", el, className)

  removeClass: (className) ->
    @find().then (el) =>
      @driver.executeScript("arguments[0].classList.remove(arguments[1])", el, className)

  toggleClass: (className) ->
    @find().then (el) =>
      @driver.executeScript("arguments[0].classList.toggle(arguments[1])", el, className)

  findAll: (selector) ->
    @driver.findElements(Driver.By.css(@_selector(selector)))

  _selector: (selector) ->
    @root + (if selector then " #{selector}" else '')

  findByText: (text) ->
    @find().then (el) ->
      el.findElement(
        # WebDriver lets you go out of the child scope
        # if you pass an absolute xpath selector
        # this is a bug in WebDriver and is terrible
        # by passing a `.` this is no longer an issue.
        Driver.By.xpath('.//*[normalize-space(text())=normalize-space("' + text + '")]')
      )

  _ensureElement: (selector) ->
    @driver.wait(
      _.bind(@isPresent, this, selector),
      10000,
      "#{@_selector(selector)} not found"
    )

  _map: (collection, callback) ->
    results = []
    _reduce = (p, f, i) ->
      p.then ->
        callback(f, i).then (v) -> results.push(v)
    _.reduce(collection, _reduce, Driver.promise.fulfilled())
      .then -> results

  sendKeys: ->
    args = arguments
    @find().then (el) =>
      el.sendKeys.apply(el, args)
