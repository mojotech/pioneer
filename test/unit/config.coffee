sinon           = require("sinon")
assert          = require("assert")
configBuilder   = require('../../lib/config_builder')
_               = require 'lodash'
CONFIG_NAMES    = [
  "tags",
  "feature",
  "require",
  "format",
  "error_formatter",
  "coffee",
  "driver",
  "preventReload"
]

describe "configuration formatter", ->
  beforeEach ->
    process.argv  = []

    this.libPath  = "wow"
    this.simpleConfig   = [
      { feature: 'test/integration/features' },
      { require: [ 'test/integration/steps', 'test/integration/widgets' ] },
      { format: 'pretty' },
      { error_formatter: 'error_formatter.js' },
      { coffee: false },
      { driver: 'phantomjs' },
      { 'prevent-browser-reload': true }
    ]

    this.multiTagConfig = [
      { tags: ["@wow", "@doge"]}
    ]

  it "should convertToExecOptions", ->
    configBuilder.convertToExecOptions(this.simpleConfig, this.libPath)
    .should.eql([
      null
      null
      "test/integration/features"
      "--require"
      "test/integration/steps"
      "--require"
      "test/integration/widgets"
      "--format=pretty"
      "--error_formatter=error_formatter.js"
      "--require"
      "wow/support"
    ])

    process.argv.should.eql(["--driver=phantomjs", "--prevent-browser-reload"])

  it "should convertToExecOptions with multiple tags", ->
    configBuilder.convertToExecOptions(this.multiTagConfig, this.libPath)
    .should.eql([null, null, "--tags=@wow", "--tags=@doge", "--require", "wow/support"])

    process.argv.should.eql([])

  it "should push command line arguments for driver and reload", ->
    configBuilder.convertToExecOptions(this.simpleConfig, this.libPath)
    process.argv.should.eql(["--driver=phantomjs", "--prevent-browser-reload"])

  it "should generate options with just commandline options", ->
    stub = sinon.stub(configBuilder, "generateOptions", (minimist, config, libPath)->
      options =
      _(CONFIG_NAMES)
      .map((name) ->
        obj = {}

        if (minimist[name]?)
          obj[name] = minimist[name]
          if name is 'require'
            if(typeof(obj[name]) == 'string')
              obj[name] = [obj[name]].concat(config[name])
            else
              config[name].map((field)->
                obj[name].push(field)
              )
        else if config[name]?
          obj[name] = config[name]

        if obj[name]? then obj else null
      )
      .compact()
      .value()
      return options
    )
    configBuilder.generateOptions({
      driver:"pretty",
      feature:"test/integration/features"
    }, {}, "wow")
    .should.eql([
      {feature: 'test/integration/features'},
      {driver: "pretty"}
    ])

  it "should generate options with just config file options", ->
    configBuilder.generateOptions({
      },{
        tags:["@wow","@doge"],
        error_formatter: "such.js",
        require: ["that.js", "this.json", "totally.css"]
      }, "wow")
    .should.eql([
      {tags: ['@wow','@doge']},
      {require: ["that.js", "this.json", "totally.css"]},
      {error_formatter: "such.js"}
    ])

  it "should generate options with both config and commandline options", ->
    configBuilder.generateOptions({
      coffee: true,
      driver: "phantomjs"
    },{
      tags:["@wow","@doge"],
      error_formatter: "such.js",
      require: ["that.js", "this.json", "totally.css"]
    }, "wow")
    .should.eql([
      {tags: ['@wow','@doge']},
      {require: ["that.js", "this.json", "totally.css"]},
      {error_formatter: "such.js"},
      {coffee: true},
      {driver: "phantomjs"}
    ])

  it "should allow command line arguments to override config file arguments", ->
    configBuilder.generateOptions({
      coffee: true,
      driver: "firefox",
      format: "pretty"
    },{
      tags:["@wow","@doge"],
      driver: "chrome",
      require: ["that.js", "this.json", "totally.css"],
      coffee: false,
      format: "json"
    }, "wow")
    .should.eql([
      {tags: ['@wow','@doge']},
      {require: ["that.js", "this.json", "totally.css"]},
      {format: "pretty"},
      {coffee: true},
      {driver: "firefox"}
    ])

  it "should allow required files from both config file and commandline options", ->
    configBuilder.generateOptions({
      require: ["wow.doge", "doge.script"]
    },{
      require: ["that.js", "this.json", "totally.css"]
    }, "wow")
    .should.eql([
      {require: ["wow.doge", "doge.script", "that.js", "this.json", "totally.css"]},
    ])
