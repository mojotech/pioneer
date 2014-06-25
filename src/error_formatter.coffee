color = require('colors')
module.exports = (failure) ->
  return format(failure)

format = (failure) ->
  message = shorten(failure, 5)
  colorFirstLine(message)

shorten = (message, numlines) ->
  message.split('\n').splice(0, numlines).join('\n')

colorFirstLine = (message) ->
  split = message.split('\n')
  split[0] = split[0].blue
  split.join('\n')
