class @Widget.Iframe extends @Widget
  root: 'iframe'

  focus: ->
    @driver.switchTo().frame(@find()).then => this

  unfocus: ->
    @driver.switchTo().defaultContent().then => this
