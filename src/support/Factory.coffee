module.exports = ->
  World      = @
  @Factories = {}

  class @Factory
    @create: (attributes = {}) ->
      @_execute =>
        World.logger.silence =>
          @_defer(@_getCreator(), @_getDefaults())

    @_getCreator: ->
      @creator.call(World)

    @_getDefaults: ->
      return @defaults unless _.isFunction(@defaults)
      @defaults()

    @_defer: (callback, args...) ->
      deferred = $.defer()

      callback.call World, args..., (error, rest...) ->
        if error
          defered.reject error
        else
          deferred.fulfill rest...
      return deferred.promise

    @_execute: (job) ->
      $.controlFlow().execute job
