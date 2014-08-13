_      = require('lodash')
Driver = require('selenium-webdriver')
$      = Driver.promise

@W = class @Widget
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

  click: (opts) ->
    @find(opts).then (el) ->
      el.click()

  fill: (opts) ->
    if !opts and !opts.value?
      throw new Error("You must pass a value to fill with. https://github.com/mojotech/pioneer/blob/master/docs/widget.md#fill")

    if _.isObject(opts)
      @find(opts.selector).then (el) ->
        el.sendKeys.apply(el, Array::slice.call(opts.value))
    else
      @find().then (el) ->
        el.sendKeys.apply(el, Array::slice.call(opts))

  read: (opts) ->
    if _.isString(opts) or opts is undefined
      @find(opts).then (el) -> el.getText()

    else
      _.defaults opts,
        transformer: (value) -> value
        selector: null

      @find(opts.selector).then (el) ->
        return el.getText().then opts.transformer

  getValue: (opts={}) ->
    if _.isString(opts)
      opts = {selector: opts}

    _.defaults opts,
      transformer: (val) -> val

    @find(opts).then (el) ->
      el.getAttribute('value').then opts.transformer

  find: (opts) ->
    deferred = new $.Deferred

    if (!opts or _.isString(opts))
      opts = {selector: opts}

    if (opts.text)
      return @_findByText(opts)

    if (@el)
      if !opts.selector
        deferred.fulfill(@el)
      else
        return @el.findElement(Driver.By.css(opts.selector))

      return deferred

    @_ensureElement(opts.selector).then =>
      @driver.findElement(Driver.By.css(@_selector(opts.selector)))

  getHtml: (opts) ->
     @find(opts).then (el) -> el.getOuterHtml()

  getText: (opts) ->
    @find(opts).then (el) -> el.getText()

  getAttribute: (attribute) ->
    @find().then (el) -> el.getAttribute(attribute)

  getInnerHTML: (opts) ->
    @find(opts).then (el) -> el.getInnerHtml()

  getOuterHTML: (opts) ->
    @find(opts).then (el) -> el.getOuterHtml()

  isPresent: (selector) ->
    @driver.isElementPresent(Driver.By.css(@_selector(selector)))

  isVisible: (opts) ->
    @find(opts).then (elm) -> elm.isDisplayed()

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

  _findByText: (opts) ->
    @find().then (el) ->
      el.findElement(
        # WebDriver lets you go out of the child scope
        # if you pass an absolute xpath selector
        # this is a bug in WebDriver and is terrible
        # by passing a `.` this is no longer an issue.
        Driver.By.xpath('.//*[normalize-space(text())=normalize-space("' + opts.text + '")]')
      )

  _ensureElement: (selector) ->
    @driver.wait(
      _.bind(@isPresent, this, selector),
      10000,
      "#{@_selector(selector)} not found"
    )

  sendKeys: (args...)->
    @find().then (el) -> el.sendKeys.apply(el, args)
