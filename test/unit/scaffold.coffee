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
    noFeature = this.sandbox.stub(configBuilder, "checkForFeature", -> true)
    configBuilder.generateOptions({
      _: []
    }, {}, this.libPath, ->)
    scaffold.callCount.should.eql(1)

  describe "createScaffold()", ->
    beforeEach ->
      this.pioneerJSON = path.join(process.cwd(), '/.pioneer.json')
      if(fs.existsSync(this.pioneerJSON))
        this.format = fs.readFileSync(this.pioneerJSON)
      else
        this.format = null
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

