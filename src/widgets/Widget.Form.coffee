Promise = require('bluebird')
_       = require('lodash')

class @Widget.Form extends @Widget
  root: 'form'

  submitSelector: ->
    @find('[type="submit"]')

  submitForm: =>
    @submitSelector().then (el) -> el.click()

  submitWith: (values) =>
    @fillAll(values)
    .then(@submitForm)

  select: (opts) ->
    if !(_.isObject(opts)) and !opts
      throw new Error('You must provide something to select by.')

    opts = if _.isObject(opts) then opts else {text: opts}

    if (opts.text? and opts.value?)
      throw new Error('You may only have one select by attribute.')
    else if opts.text?
      @_selectByText(opts.text)
    else if opts.value?
      @_selectByValue(opts.value)

  _selectByText: (text) ->
    @find({text: text}).then (el) ->
      el.click()

  _selectByValue: (value) ->
    @find("option[value=\"#{value}\"]").then (el) ->
      el.click()

  fillAll: (values) ->
    @_map Object.keys(values), (f) => @fill({
      selector: @_name(f)
      value: values[f]
    })

  readAll: ->
    _readAll = (f) =>
      @getValue(@_name(f)).then (v) -> [f, v]

    @_map(@fields, _readAll).then (read) ->
      _.object(read)

  _name: (name) ->
    "[name='#{name}']"
