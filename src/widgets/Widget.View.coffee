class @Widget.View extends @Widget
  constructor: (attributes = {}) ->
    throw new Error("A Widget.View requires regionPath") unless attributes.regionPath?
    super

  ui: (ui)->
    throw new Error("A UI selector is required") unless ui?

    regions = @regionPath.split(".")
    viewPath = ("#{region}.currentView" for region in regions).join(".")
    stmt = "return #{if @appPath then @appPath+'.' else ''}#{viewPath}.ui.#{ui}.get(0)"
    @driver.executeScript(stmt)
