moment        = require 'moment'
fs            = require 'fs'
minimist      = require 'minimist'
configBuilder = require './config_builder'
module.exports = (libPath, config) ->
  args = minimist(process.argv.slice(2))
  process.argv = []
  if(args.configPath && fs.existsSync(args.configPath))
    configPath = args.configPath
  else
    configPath = config
  console.log 'Configuration loaded from ' + configPath + '\n'
  getSpecifications(configPath, libPath, args)

getSpecifications = (path, libPath, args) ->
  obj = {}
  fs.readFile(path,
    'utf8',
    (err, data)->
      throw err if(err)
      object = JSON.parse(data)
      applySpecifications(object, libPath, args)
  )

applySpecifications = (obj, libPath, args) ->
  start(configBuilder.generateOptions(args, obj, libPath))

start = (opts) ->
  timeStart = new Date().getTime()

  require('./environment')()

  cucumber = require 'cucumber'
  cucumber.Cli(opts).run ->
    testTime = moment.duration(new Date().getTime() - timeStart)._data
    console.log "Duration " + "(" + testTime.minutes + "m:" + testTime.seconds + "s:" + testTime.milliseconds + "ms)"
