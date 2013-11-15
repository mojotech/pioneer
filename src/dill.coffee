module.exports = (lib) ->
  process.argv.push "--require"
  process.argv.push "#{lib}/support"

  process.argv.push "--require"
  process.argv.push "features"

  require('./environment')()
  require(require.resolve('cucumber').replace /lib\/cucumber\.js$/, 'bin/cucumber.js')
