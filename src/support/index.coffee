Driver          = require('selenium-webdriver')
$               = Driver.promise
argv            = require('minimist')(process.argv)
_               = require('lodash')
color           = require('colors')
SauceLabs       = require('saucelabs')
sauceLabs = new SauceLabs
  username: process.env.SAUCE_USERNAME
  password: process.env.SAUCE_ACCESS_KEY

global.timeout  = 5000

module.exports = ->
  @Driver = Driver

  _Before = @Before
  _After  = @After

  currentFeatureName = ''
  currentScenarioName = ''

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

  flowStep = (code, args, pending, successCallback, errCallback) =>
    @Pending = (reason) -> successCallback = _.partial pending, reason

    $
    .createFlow (flow) =>
      flow.execute =>
        code.apply(@, args)
    .then (result) ->
      successCallback null, result
    , errCallback

  @Given = @When = (pattern, code) =>
    @defineStep pattern, (args..., callback) =>
      @lastStepType = 'Given'
      flowStep code, args, callback.pending, callback, callback

  @Then = (pattern, code) =>
    @defineStep pattern, (args..., callback) =>
      @lastStepType = 'Then'
      start = new Date

      callforth = =>
        flowStep code, args, callback.pending, callback, (error) =>
          if new Date - start > timeout
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

  @BeforeFeature (code, callback) ->
    currentFeatureName = code.getPayloadItem('feature').getName()
    callback()

  @BeforeScenario (code, callback) ->
    currentScenarioName = code.getPayloadItem('scenario').getName()
    callback()

  @Before =>

    pioneerConfig = global.__pioneerConfig

    @lastStepType = 'Given'
    if !@driver || !shouldPreventBrowserReload()
      if pioneerConfig.server

        capabilities = _.extend({
          browserName: "Chrome"
          platform: "Windows 2012"
          name: "#{currentFeatureName} | #{currentScenarioName}"
          "selenium-version": "2.43.0"
          build: process.env["bamboo.buildNumber"] || null
          username: process.env.SAUCE_USERNAME
          accessKey: process.env.SAUCE_ACCESS_KEY
        }, pioneerConfig.capabilities)

        @driver = new Driver.Builder()
          .usingServer(pioneerConfig.server)
          .withCapabilities(capabilities)
          .build()
      else

        @driver = new Driver.Builder()
          .withCapabilities(Driver.Capabilities[argv.driver || 'chrome']())
          .build()

      @driver.visit = @driver.get


  @_scenarioStatus = null
  @StepResult (code, callback) =>
    #tell saucelabs if it passed or failed via rest api
    succeeded = code.getPayloadItem('stepResult').isSuccessful()
    failed = code.getPayloadItem('stepResult').isFailed()
    pending = code.getPayloadItem('stepResult').isPending()
    skipped = code.getPayloadItem('stepResult').isSkipped()
    notDefined = code.getPayloadItem('stepResult').isUndefined()
    if failed then @_scenarioStatus = false
    if succeeded then @_scenarioStatus = true
    if pending or skipped or notDefined then @_scenarioStatus = null
    callback()

  @AfterScenario (code, callback) =>

    nextTest = =>
      @_scenarioStatus = null
      if not shouldPreventBrowserReload()
        terminateDriver().then -> callback()
      else
        callback()

    if @_scenarioStatus is null
      nextTest()
    else
      # send scenario response to saucelabs
      @driver.session_.then (driverData) =>
        sessionId = driverData.id_
        data =
          passed: @_scenarioStatus
        sauceLabs.updateJob sessionId, data, (err, res) ->
          # This code will always run
          # If you are connecting through saucelabs the result of the test will
          # be updated via their api to include the pass/fail status.
          # If you are not connected through saucelabs the sessionId will not
          # be found, so you will get an error, but we can safely ignore it.
          # Note that in the case of an error when running through saucelabs
          # it will be ignored and the test wont be marked as pass or fail,
          # but at least the tests will continue to run and will exit correctly

          nextTest()

  @registerHandler "AfterFeatures", (event, callback) =>
    if shouldPreventBrowserReload()
      terminateDriver().then -> callback()
    else
      callback()

  shouldPreventBrowserReload = ->
    argv['prevent-browser-reload']?

  terminateDriver = =>
    @driver.close()
    @driver.quit()

  @When /^I Freeze$/, @Freeze
