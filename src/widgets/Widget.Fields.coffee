_ = require("lodash")

class @Widget.Fields extends @Widget
  fillAll: (values) ->
    @_map Object.keys(values), (f) => @fill({
      selector: @_name(f)
      value: values[f]
    })

  readAll: ->
    _readAll = (f) =>
      @read(@_name(f)).then (v) -> [f, v]

    @_map(@fields, _readAll).then (read) ->
      _.object(read)

  _name: (name) ->
    "[name='#{name}']"

  _type: (type) ->
    "[type='#{type}']"

  _map: (collection, callback) ->
    results = []
    _reduce = (p, f, i) ->
      p.then ->
        callback(f, i).then (v) -> results.push(v)
    _.reduce(collection, _reduce, Driver.promise.fulfilled())
      .then -> results

