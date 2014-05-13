moment = require 'moment'
module.exports = (lib) ->
  timeStart = new Date().getTime()
  process.argv.push "--require"
  process.argv.push "#{lib}/support"

  process.argv.push "--require"
  process.argv.push "features"

  require('./environment')()
  require(require.resolve('cucumber').replace /lib\/cucumber\.js$/, 'bin/cucumber.js')

  process.on 'exit', ->
    testTime = moment.duration(new Date().getTime() - timeStart)._data
    console.log "Duration " + "(" + testTime.minutes + "m:" + testTime.seconds + "s:" + testTime.milliseconds + "ms)"
