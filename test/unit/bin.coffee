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
