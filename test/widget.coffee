ROOT    = {}
sinon   = require("sinon")
assert  = require("assert")

require("../src/environment").call(ROOT)
require("../src/support/Widget").call(ROOT)

describe "widgets", ->
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
