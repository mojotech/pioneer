moment = require 'moment'
module.exports = (lib, eformatter) ->
  timeStart = new Date().getTime()
  process.argv.push("--error_formatter=#{eformatter}") unless process.argv.filter(checkForErrorFormatter).length  
  process.argv.push "--require"
  process.argv.push "#{lib}/support"

  require('./environment')()
  require(require.resolve('cucumber').replace /lib\/cucumber\.js$/, 'bin/cucumber.js')

  process.on 'exit', ->
    testTime = moment.duration(new Date().getTime() - timeStart)._data
    console.log "Duration " + "(" + testTime.minutes + "m:" + testTime.seconds + "s:" + testTime.milliseconds + "ms)"

checkForErrorFormatter = (element) ->
  return !element.indexOf('--error_formatter') 
