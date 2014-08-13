sinon           = require("sinon")
assert          = require("assert")
chai            = require("chai")
expect          = chai.expect
configBuilder   = require('../../lib/config_builder')
_               = require('lodash')
CONFIG_NAMES    = [
  "tags",
  "feature",
  "require",
  "format",
  "error_formatter",
  "coffee",
  "driver",
  "preventReload",
  "scaffold"
]

describe "Pioneer configuration", ->
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
        { 'preventReload': true }
      ]

      this.multiTagConfig = [
        { tags: ["@wow", "@doge"]}
      ]
      scaffoldStub = sinon.stub(configBuilder, "checkForFeature", -> false)

    afterEach ->
      configBuilder.checkForFeature.restore()


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
        "--format=#{this.libPath}/pretty"
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

    describe "generating options", ->
      beforeEach ->
        stub = sinon.stub(configBuilder, "convertToExecOptions", (objArray, libPath) ->)

      afterEach ->
        configBuilder.convertToExecOptions.restore()

      it "should generate options with just commandline options", ->
        configBuilder.generateOptions({
          driver:"pretty",
          feature:"test/integration/features"
        }, {}, this.libPath)

        configBuilder.convertToExecOptions
        .calledWith([
          {feature: 'test/integration/features'},
          {driver: "pretty"}
        ])

      it "should generate options with just config file options", ->
        configBuilder.generateOptions({
          },{
            tags:["@wow","@doge"],
            error_formatter: "such.js",
            require: ["that.js", "this.json", "totally.css"]
          }, this.libPath)

        configBuilder.convertToExecOptions
        .calledWith([
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
        }, this.libPath)

        configBuilder.convertToExecOptions
        .calledWith([
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
        }, this.libPath)

        configBuilder.convertToExecOptions
        .calledWith([
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
        }, this.libPath)

        configBuilder.convertToExecOptions
        .calledWith([
          {require: ["wow.doge", "doge.script", "that.js", "this.json", "totally.css"]},
        ])

  describe "preventReload flag", ->

    beforeEach ->
      this.libPath  = "wow"
      process.argv = []
      scaffoldStub = sinon.stub(configBuilder, "checkForFeature", -> false)

    afterEach ->
      configBuilder.checkForFeature.restore()

    it "should not prevent browser reload without any specifications" , ->
      configBuilder.generateOptions({}, {}, this.libPath)
      process.argv.should.eql([])

    it "should not prevent browser reload when the config file specifies boolean false" , ->
      configBuilder.generateOptions({}, {"preventReload":false}, this.libPath)
      process.argv.should.eql([])

    it "should not prevent browser reload when the config file specifies string false" , ->
      configBuilder.generateOptions({}, {"preventReload":"false"}, this.libPath)
      process.argv.should.eql([])

    it "should not prevent browser reload when the config file specifies boolean true" , ->
      configBuilder.generateOptions({}, {"preventReload":true}, this.libPath)
      process.argv.should.eql(["--prevent-browser-reload"])

    it "should not prevent browser reload when the config file specifies string true" , ->
      configBuilder.generateOptions({}, {"preventReload":"true"}, this.libPath)
      process.argv.should.eql(["--prevent-browser-reload"])

    it "should prevent browser reload when specified on the commandline" , ->
      configBuilder.generateOptions({"preventReload": true}, {}, this.libPath)
      process.argv.should.eql(["--prevent-browser-reload"])

    it "should prevent browser reload when specified on the commandline with string" , ->
      configBuilder.generateOptions({"preventReload": "true"}, {}, this.libPath)
      process.argv.should.eql(["--prevent-browser-reload"])

    it "should not prevent browser reload when specified on the commandline" , ->
      configBuilder.generateOptions({"preventReload": false}, {}, this.libPath)
      process.argv.should.eql([])

    it "should not prevent browser reload when specified on the commandline with string" , ->
      configBuilder.generateOptions({"preventReload": "false"}, {}, this.libPath)
      process.argv.should.eql([])

    it "should prevent browser reload when specified on the commandline and false in config file" , ->
      configBuilder.generateOptions({"preventReload": true}, {"preventReload": false}, this.libPath)
      process.argv.should.eql(["--prevent-browser-reload"])

    it "should not prevent browser reload when specified false on the commandline and true in config file" , ->
      configBuilder.generateOptions({"preventReload": false}, {"preventReload": true}, this.libPath)
      process.argv.should.eql([])

    it "should only push the argument once when specified in both config and commandline", ->
      configBuilder.generateOptions({"preventReload": true}, {"preventReload": true}, this.libPath)
      process.argv.should.eql(["--prevent-browser-reload"])

  describe "driver flag", ->

    beforeEach ->
      this.libPath  = "wow"
      process.argv = []
      scaffoldStub = sinon.stub(configBuilder, "checkForFeature", -> false)

    afterEach ->
      configBuilder.checkForFeature.restore()

    it "should not be included when not specified" , ->
      configBuilder.generateOptions({}, {}, this.libPath)
      process.argv.should.eql([])

    it "should be included when specifed on the commandline" , ->
      configBuilder.generateOptions({"driver":"chrome"}, {}, this.libPath)
      process.argv.should.eql(["--driver=chrome"])

    it "should be included when specifed on the commandline" , ->
      configBuilder.generateOptions({}, {"driver":"firefox"}, this.libPath)
      process.argv.should.eql(["--driver=firefox"])

    it "should allow commandline to take precedence over config file", ->
      configBuilder.generateOptions({"driver":"phantomjs"}, {"driver":"firefox"}, this.libPath)
      process.argv.should.eql(["--driver=phantomjs"])
