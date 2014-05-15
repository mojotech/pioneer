moment = require 'moment'
detector = require('./support/detector')
require('colors')

module.exports = (lib) ->
  detector.supportsDriver (notSupported) ->
    process.exit(1) if notSupported
    timeStart = new Date().getTime()

    process.argv.push "--require"
    process.argv.push "#{lib}/support"

    process.argv.push "--require"
    process.argv.push "features"

    require('./environment')()
    require(require.resolve('cucumber').replace /lib\/cucumber\.js$/, 'bin/cucumber.js')

    process.on 'exit', ->
      testTime = moment.duration(new Date().getTime() - timeStart)._data
      console.log "Duration (" + "#{testTime.minutes}m:#{testTime.seconds}s:#{testTime.milliseconds}ms".green + ")"

