promise = require("bluebird")
sinon   = require("sinon")
assert  = require("assert")

ROOT    =
  driver:
    wait: -> promise.resolve()
    findElement: -> promise.resolve("fake element")

require("../../lib/environment").call(ROOT)
require("../../lib/support/widgets").call(ROOT)

describe "widgets", ->
  describe "root should be overideable", ->
    before ->
      this.OptionWidget = new ROOT.Widget(
        root: "div"
      )

      this.ExtendWidget = new (ROOT.Widget.extend({
        root: "wow"
      }))

    it "should persit when passed via the constructor", ->
      assert.equal(this.OptionWidget.root, "div")

    it "should persit when passed via an extend", ->
      assert.equal(this.ExtendWidget.root, "wow")

  describe "initialize should be overideable", ->
    beforeEach ->
      this.spy = sinon.spy()

    it "should work when defined as a constructor arg", ->
      new ROOT.Widget
        initialize: this.spy

      assert(this.spy.called, true)

    it "should work when defined using the extend syntax", ->
      new (ROOT.Widget.extend
        initialize: this.spy
      )

      assert(this.spy.called, true)

  describe "find based constructor", ->

    it "should return a thenable interface", ->
      assert.notEqual(ROOT.Widget.find(root: "body").then, undefined)

    it "should set the el property", ->
      ROOT.Widget.find(root: "body").then (widget) ->
        assert.notEqual(widget.el, undefined)

    it "should set attributes based on find args", ->
      ROOT.Widget.find(root: "body").then (widget) ->
        widget.root.should.eql("body")
