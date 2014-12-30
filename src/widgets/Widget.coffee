_       = require('lodash')
Driver  = require('selenium-webdriver')
$       = Driver.promise

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

  staticMethods = ["click", "fill", "hover", "doubleClick", "read", "isPresent", "isVisible", "getAttribute", "getValue", "getText", "getInnerHTML", "getOuterHTML", "hasClass", "sendKeys", "clear"]
  for staticMethod in staticMethods
    m = (args...) =>
      @find({root: "html"}).then (w) ->
        w[args[0]].apply(w, args.slice(1))

    @[staticMethod] = _.partial(m, staticMethod)

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
    if !(_.isObject(opts)) and !opts
      throw new Error("You must pass a value to fill with. https://github.com/mojotech/pioneer/blob/master/docs/widget.md#fill")

    opts = if _.isObject(opts) then opts else {value: opts}

    @find(opts.selector).then (el) ->
      el.clear().then ->
        el.sendKeys.apply(el, Array::slice.call(opts.value))

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

  getAttribute: (opts) ->
    if _.isString(opts)
      opts = {attribute: opts}
    @find(opts).then (el) -> el.getAttribute(opts.attribute)

  getInnerHTML: (opts) ->
    @find(opts).then (el) -> el.getInnerHtml()

  getOuterHTML: (opts) ->
    @find(opts).then (el) -> el.getOuterHtml()

  isPresent: (selector) ->
    if @_selector(selector) != "undefined"
      @driver.isElementPresent(Driver.By.css(@_selector(selector)))
    else
      @el.isDisplayed()

  isVisible: (opts={}) ->
    if(_.isString(opts))
      opts = {selector: opts}
    @isPresent(opts.selector).then (present) =>
      if(present)
        @find(opts).then (elm) -> elm.isDisplayed()
      else
        false

  addClass: (opts) ->
    if _.isString(opts)
      opts = {className: opts}
    @find(opts.selector).then (el) =>
      @driver.executeScript("arguments[0].classList.add(arguments[1])", el, opts.className)

  removeClass: (opts) ->
    if _.isString(opts)
      opts = {className: opts}
    @find(opts.selector).then (el) =>
      @driver.executeScript("arguments[0].classList.remove(arguments[1])", el, opts.className)

  toggleClass: (opts) ->
    if _.isString(opts)
      opts = {className: opts}
    @find(opts.selector).then (el) =>
      @driver.executeScript("arguments[0].classList.toggle(arguments[1])", el, opts.className)

  hasClass: (opts) ->
    if _.isString(opts)
      opts = {className: opts}
    @find(opts.selector).then (el) =>
      @driver.executeScript(
        "return arguments[0].classList.contains(arguments[1])",
        el, opts.className
      )

  findAll: (selector) ->
    @find().then (el) =>
      new World.Widget.List({
        el: el
        itemSelector: selector
      })

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
      global.timeout,
      "#{@_selector(selector)} not found"
    )

  sendKeys: (opts...)->
    if(opts.length > 1)
      @sendKeys({keys: opts})
    else
      opts = opts[0]
      if !(_.isObject(opts))
        opts = {keys: Array::concat(opts)}
      @find(opts.selector).then (el) -> el.sendKeys.apply(el, Array::concat(opts.keys))

  hover: (opts) ->
    @find(opts).then (el) =>
      new Driver.ActionSequence(@driver)
      .mouseMove(el)
      .perform()
      .then => this

  doubleClick: (opts) ->
    @find(opts)
    .then (el) =>
      new Driver.ActionSequence(@driver)
      .doubleClick(el)
      .perform()
      .then => this

  clear: (opts) ->
    @find(opts)
    .then (el) =>
      el.clear().then => this

  _map: (collection, callback) ->
    results = []
    _reduce = (p, f, i) ->
      p.then ->
        callback(f, i).then (v) -> results.push(v)
    _.reduce(collection, _reduce, Driver.promise.fulfilled())
      .then -> results
