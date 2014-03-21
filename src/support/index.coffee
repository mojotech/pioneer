module.exports = ->
  @logger = require './logger'

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

  @Given = @When = @Then = @And = (pattern, code) =>
    @defineStep pattern, (args..., callback) =>
      start = new Date

      callforth = =>
        $
        .createFlow (flow) =>
          flow.execute => code.apply(@, args)
        .then _.partial(callback, null), (error) =>
          if new Date - start > @timeout
            callback(error)
          else
            $.delayed(1000).then -> callforth()

      callforth()

  @Before ->
    @driver = new Driver.Builder().withCapabilities(Driver.Capabilities.chrome()).build()

  @After ->
    @driver.close()
    @driver.quit()
