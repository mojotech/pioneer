class @Widget.Form extends @Widget.Fields
  submitSelector: ->
    @_type('submit')

  submitWith: (values) =>
    @fillAll(values)
    @click @submitSelector()
