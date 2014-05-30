class @Widget.Fields extends @Widget
  fillAll: (values) ->
    @_map @fields, (f) => @fill(@_name(f), values[f])

  readAll: ->
    _readAll = (f) =>
      @read(@_name(f)).then (v) -> [f, v]

    @_map(@fields, _readAll).then (read) ->
      _.object(read)

  _name: (name) ->
    "[name='#{name}']"

  _type: (type) ->
    "[type='#{type}']"
