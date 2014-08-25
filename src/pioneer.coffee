moment        = require 'moment'
fs            = require 'fs'
path          = require 'path'
minimist      = require 'minimist'
configBuilder = require './config_builder'
color         = require 'colors'
cucumber      = require 'cucumber'

init = (libPath) ->
  args = minimist(process.argv.slice(2))
  process.argv = []
  if isHelpRequested(args)
    console.log 'What would you like help with?\n'
  else if isVersionRequested(args)
    console.log 'Version: 0.8.2\n'
  else
    if(args.configPath && fs.existsSync(args.configPath))
      configPath = args.configPath
    else
      p = path.join(process.cwd(), '/.pioneer.json')
      if(fs.existsSync(p))
        configPath = p
      else
        configPath = null
    if(configPath)
      console.log ('Configuration loaded from ' + configPath + '\n').yellow.inverse
    else
      console.log ('No configuration path specified.\n').yellow.inverse
    getSpecifications(configPath, libPath, args)

getSpecifications = (path, libPath, args) ->
  obj = {}
  if(path)
    fs.readFile(path,
      'utf8',
      (err, data)->
        throw err if(err)
        object = parseAndValidateJSON(data, path)
        applySpecifications(object, libPath, args)
    )
  else
    applySpecifications(obj, libPath, args)

applySpecifications = (obj, libPath, args) ->
  start(configBuilder.generateOptions(args, obj, libPath))

start = (opts) ->
  timeStart = new Date().getTime()

  require('./environment')()

  cucumber.Cli(opts).run (success) ->
    testTime = moment.duration(new Date().getTime() - timeStart)._data
    console.log "Duration " + "(" + testTime.minutes + "m:" + testTime.seconds + "s:" + testTime.milliseconds + "ms)"
    process.exit(if success then 0 else 1)

parseAndValidateJSON = (config, path) ->
  try
    JSON.parse(config)
  catch err
    throw new Error(path + " does not include a valid JSON object.\n")

isHelpRequested = (args) ->
  args.help || args.h

isVersionRequested = (args) ->
  args.version || args.v

module.exports = init
module.exports._parseAndValidateJSON = parseAndValidateJSON
