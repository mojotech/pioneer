chai            = require('chai')
sinon           = require("sinon")
sinonChai       = require("sinon-chai")

chai.should()
chai.use(sinonChai)

Pioneer         = require("../../lib/pioneer.js")

describe "Pioneer Kickoff File", ->

  describe "isVersionRequested()", ->

    it "should return true when --version is passed", ->
      Pioneer::isVersionRequested({version: true})
      .should.be.true

    it "should return true when -v is passed", ->
      Pioneer::isVersionRequested({v: true})
      .should.be.true

    it "should return null when neither -v or --version is true", ->
      # expect(Pioneer::isVersionRequested({}))
      # .to.eql(undefined)

  describe "When Version is requested", ->
    beforeEach ->
      @sandbox = sinon.sandbox.create()
      @sandbox.stub(Pioneer.prototype, "isVersionRequested", -> true )
      @sandbox.stub(Pioneer.prototype, "getSpecifications", -> true )
      @consoleSpy = @sandbox.spy(console, 'log')

    afterEach ->
      @sandbox.restore()

    it "should log the current version", ->
      currentV = require('../../package').version
      new Pioneer("wow")
      @consoleSpy.should.have.been.calledWith(currentV);

  describe "isVerbose", ->

    describe "when only a command line value is passed", ->

      it "should treat true and 'true' as true", ->
        Pioneer::isVerbose({verbose: true})
        .should.be.true

        Pioneer::isVerbose({verbose: "true"})
        .should.be.true

      it "should treat missing or 'false' value as false", ->
        Pioneer::isVerbose({verbose: "false"})
        .should.be.false

        Pioneer::isVerbose({})
        .should.be.false

    describe "when only a config value is passed", ->

      it "should return true when passed a truthy value", ->
        Pioneer::isVerbose({}, {verbose: true})
        .should.be.true

      it "should return false when passed a falsey value", ->
        Pioneer::isVerbose({}, {verbose: ""})
        .should.be.false

    describe "when a config and command line value are passed", ->

      it "should defer to the command line value", ->
        Pioneer::isVerbose({verbose: true}, {verbose: false})
        .should.be.true

        Pioneer::isVerbose({verbose: false}, {verbose: true})
        .should.be.false
