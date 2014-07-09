class @Widget.Form extends @Widget.Fields
  root: 'form'

  submitSelector: ->
    @_type('submit')

  submitWith: (values) =>
    @fillAll(values)
    @click @submitSelector()
