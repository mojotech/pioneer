Driver = require('selenium-webdriver')
_      = require('lodash')
color  = require('colors')
module.exports = ->
  @timeout = 5000

  @visit = (path) =>
    @driver.get "#{@host}#{path}"

  _Before = @Before
  _After  = @After

  @_inFlow = (code, callback) ->
    $.createFlow (flow) =>
      flow.execute => code.call(@)
    .then _.partial(callback, null),
      (err) -> throw err

  @Before = (code) ->
    _Before (callback) =>
      @_inFlow code, callback

  @After = (code) ->
    _After (callback) =>
      @_inFlow code, callback

  @BeforeAll = (code) ->
    unless @_ranBeforeAll
      @_ranBeforeAll = true
      @Before code

  @AfterAll = (code) ->
    unless @_ranAfterAll
      @_ranAfterAll = true
      @After code

  flowStep = (code, args, successCallback, errCallback) =>
    $
    .createFlow (flow) =>
      flow.execute =>
        code.apply(@, args)
    .then _.partial(successCallback, null), errCallback

  @Given = @When = (pattern, code) =>
    @defineStep pattern, (args..., callback) =>
      @lastStepType = 'Given'
      flowStep code, args, callback, callback

  @Then = (pattern, code) =>
    @defineStep pattern, (args..., callback) =>
      @lastStepType = 'Then'
      start = new Date

      callforth = =>
        flowStep code, args, callback, (error) =>
          if new Date - start > @timeout
            callback(error)
          else
            $.delayed(1000).then -> callforth()

      callforth()

  @And = (pattern, code) =>
    @[@lastStepType](pattern, code)

  @Freeze = ->
    keyPress = false
    stdin = process.stdin
    stdin.setRawMode(true)
    stdin.resume()
    stdin.setEncoding('utf8')
    console.log('Press any key to continue...'.yellow.inverse)
    process.stdin.on('data', ((key) ->
      keyPress = true
    ))
    @driver.wait(
      (()->
        return keyPress
    ), Infinity).then -> process.stdin.pause()

  @Before ->
    @lastStepType = 'Given'
    if !@driver || !shouldPreventBrowserReload()
      @driver = new Driver.Builder().withCapabilities(Driver.Capabilities[argv.driver || 'chrome']()).build()

  @After ->
    terminateDriver() unless shouldPreventBrowserReload()

  @registerHandler "AfterFeatures", (event, callback) =>
    terminateDriver() if shouldPreventBrowserReload()

  shouldPreventBrowserReload = ->
    argv['prevent-browser-reload']?

  terminateDriver = =>
    @driver.close()
    @driver.quit()

  @When /^I Freeze$/, @Freeze
