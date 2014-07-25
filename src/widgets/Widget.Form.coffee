Promise = require 'bluebird'

class @Widget.Form extends @Widget.Fields
  root: 'form'

  submitSelector: (node) ->
    if node?
      if _.isString(node)
        @find(node)
      else
        Promise.resolve(node)
    else
      @find('[type="submit"]')

  submitForm: =>
    @submitSelector().then (el) -> el.click()

  submitWith: (values) =>
    @fillAll(values)
    .then(@submitForm)
