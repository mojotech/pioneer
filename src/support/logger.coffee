log     = console.log
write   = process.stdout.write

LEVEL   = process.env.LOG_LEVEL?.toLowerCase() || 'none'
LEVELS  = ['none', 'error', 'warn', 'info']

logging = (level) ->
  LEVELS.indexOf(LEVEL) >= LEVELS.indexOf(level)

module.exports =
  info: (messages...) ->
    log messages.join(' ') if logging('info')

  warn: (messages...) ->
    log messages.join(' ') if logging('warn')

  error: (messages...) ->
    log messages.join(' ') if logging('error')

  silence: (code) ->
    if logging('info')
      code()
    else
      console.log = process.stdout.write = ->
      code().then ->
        [console.log, process.stdout.write] = [log, write]
        arguments[0]
