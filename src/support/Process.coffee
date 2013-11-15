log   = require('./logger')
spawn = require('child_process').spawn

module.exports = ->
  @Processes = {}

  class @Process
    constructor: (file, message, options = {}) ->
      @file = file
      @message = message
      _.extend(@options, options)

    start: (args...) ->
      unless @_started
        @_started = $.defer()
        @_process = spawn('node', [@file].concat(args))
        @_process.stdout.on 'data', @_stdout
        @_process.stderr.on 'data', @_stderr

        @_process.on 'exit', @_exit
        @_process.on 'error', @_error
        @_process.on 'close', @_close
        @_process.on 'disconnect', @_disconnect
        @_process.on 'message', @_message

        process.on 'exit', @stop
        process.on 'error', @stop

      @_started.promise

    stop: =>
      @_process.kill() and (@_process = null) if @_process
      $.fulfilled(!@_process)

    _stdout: (data) =>
      @_logBuffer(log.info, "STDOUT", data)

      if @_started.promise.isPending()
        @_started.fulfill() if ~data.toString().indexOf(@message)

    _stderr: (data) =>
      @_logBuffer log.warn, "STDERR", data

    _exit: (code, signal) =>
      @_log log.error, "EXIT", [code, signal].join(', ')

    _error: (error) =>
      @_started.reject(error)

    _close: (code, signal) =>
      @_log log.warn, "CLOSE", [code, signal].join(', ')

    _disconnect: =>
      @_log log.info, "DISCONNECT"

    _message: (message) =>
      @_log log.info, "MESSAGE", message

    _log: (logger, type, data) =>
      logger "#{@file}:#{type} - #{data}" if data

    _logBuffer: (logger, type, buffer) =>
      @_log(logger, type, line) for line in buffer.toString().split("\n")
