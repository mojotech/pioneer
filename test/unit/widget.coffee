ROOT    = {}
sinon   = require("sinon")
assert  = require("assert")

require("../../src/environment").call(ROOT)
require("../../src/support/Widget").call(ROOT)

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
