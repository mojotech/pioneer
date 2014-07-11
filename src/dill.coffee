moment = require 'moment'
module.exports = (lib, eformatter) ->
  timeStart = new Date().getTime()
  execOptions = process.argv or []
  execOptions.push("--error_formatter=#{eformatter}") unless process.argv.filter(checkForErrorFormatter).length
  execOptions.push "--require"
  execOptions.push "#{lib}/support"

  require('./environment')()

  cucumber = require 'cucumber'
  cucumber.Cli(execOptions).run ->
    testTime = moment.duration(new Date().getTime() - timeStart)._data
    console.log "Duration " + "(" + testTime.minutes + "m:" + testTime.seconds + "s:" + testTime.milliseconds + "ms)"

checkForErrorFormatter = (element) ->
  return !element.indexOf('--error_formatter')
