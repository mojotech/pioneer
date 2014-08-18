sinon           = require("sinon")
assert          = require("assert")
_               = require('lodash')
fs              = require('fs')
path            = require('path')
rmdir           = require('rimraf').sync
configBuilder   = require('../../lib/config_builder')
scaffoldBuilder = require('../../lib/scaffold_builder')

describe "Scaffold Builder", ->
  beforeEach ->
    this.libPath = "wow"
    this.sandbox = sinon.sandbox.create()
    overwrite = this.sandbox.stub(scaffoldBuilder,
      "askToOverWrite",
      (file, data) ->
        fs.writeFileSync(file, data)
    )

  afterEach ->
    this.sandbox.restore()

  it "should be called if no feature path is specified", ->
    scaffold = this.sandbox.stub(scaffoldBuilder, "featureNotSpecified", ->)
    noFeature = this.sandbox.stub(configBuilder, "hasFeature", -> false)
    configBuilder.generateOptions({
      _: []
    }, {}, this.libPath, ->)
    scaffold.callCount.should.eql(1)

  describe "hasFeature()", ->

    it "should return false when there is no feature file specified", ->
      configBuilder.hasFeature([{}]).should.eql(false)

    it "should return true with a feature file specified", ->
      configBuilder.hasFeature([{feature:"myFeatureFile"}]).should.eql(true)

    it "should return false with complicated options", ->
      configBuilder.hasFeature([{
        tags: "@suchtag",
        require: ["file1", "file2", "file3"],
        coffe: true,
        error_formatter: "nice_errors.js"
      }]).should.eql(false)

    it "should return true with complicated options", ->
      configBuilder.hasFeature([{
        feature: "featurefile",
        tags: "@suchtag",
        require: ["file1", "file2", "file3"],
        coffee: true,
        error_formatter: "nice_errors.js"
      }]).should.eql(true)

  describe "createScaffold()", ->
    beforeEach ->
      this.pioneerJSON = path.join(process.cwd(), '/.pioneer.json')
      if(fs.existsSync(this.pioneerJSON))
        this.format = fs.readFileSync(this.pioneerJSON)
      else
        this.format = null
      logs = this.sandbox.stub(scaffoldBuilder, "_logCompleted", -> )
      scaffoldBuilder.createScaffold()

    afterEach ->
      rmdir(path.join(process.cwd(), '/tests'), (error)->)
      scaffoldBuilder.askToOverWrite.restore()
      if(this.format)
        fs.writeFileSync(this.pioneerJSON, this.format)
      else
        fs.unlinkSync(path.join(process.cwd(), '/.pioneer.json'))

    it "should create a tests/ directory", ->
      fs.existsSync(path.join(process.cwd(), '/tests')).should.be.true

    it "should create a features/ directory", ->
      fs.existsSync(path.join(process.cwd(), '/tests/features')).should.be.true

    it "should create a fixtures/ directory", ->
      fs.existsSync(path.join(process.cwd(), '/tests/fixtures')).should.be.true

    it "should create a steps/ directory", ->
      fs.existsSync(path.join(process.cwd(), '/tests/steps')).should.be.true

    it "should create a simple feature", ->
      fs.existsSync(path.join(process.cwd(), '/tests/features/simple.feature')).should.be.true

    it "should create simple stpes", ->
      fs.existsSync(path.join(process.cwd(), '/tests/steps/simple.js')).should.be.true

