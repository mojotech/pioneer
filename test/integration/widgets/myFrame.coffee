module.exports = ->
  world = this
  @widgets = @Widgets || {}

  @Widgets.Myframe = @Widget.Iframe.extend
    getParentText: (selector) ->
      page = new world.Widget({root: 'html'})
      page.read(selector)
