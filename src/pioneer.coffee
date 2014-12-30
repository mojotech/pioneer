moment          = require('moment')
fs              = require('fs')
path            = require('path')
minimist        = require('minimist')
configBuilder   = require('./config_builder')
scaffoldBuilder = require('./scaffold_builder')
color           = require('colors')
cucumber        = require('cucumber')

class Pioneer
  constructor: (libPath) ->
    args = minimist(process.argv.slice(2))
    process.argv = []

    if this.isVersionRequested(args)
      console.log require('../package').version
      return
    if(args.configPath && fs.existsSync(args.configPath))
      configPath = args.configPath
    else if args.scaffold
      scaffoldBuilder.createScaffold()
    else
      p = path.join(process.cwd(), '/pioneer.json')
      if(fs.existsSync(p))
        configPath = p
      else
        configPath = null

    if args.verbose
      if configPath
        console.log ('Configuration loaded from ' + configPath).yellow.inverse
      else
        console.log ('No configuration path specified').yellow.inverse

    this.getSpecifications(configPath, libPath, args)

  getSpecifications: (path, libPath, args) ->
    obj = {}
    if(path)
      fs.readFile(path,
        'utf8',
        (err, data) =>
          throw err if(err)
          object = this.parseAndValidateJSON(data, path)
          this.applySpecifications(object, libPath, args)
      )
    else
      this.applySpecifications(obj, libPath, args)

  applySpecifications: (obj, libPath, args) ->
    opts = configBuilder.generateOptions(args, obj, libPath)
    this.start(opts) if opts

  start: (opts) ->
    require('./environment')()

    cucumber.Cli(opts).run (success) ->
      process.exit(if success then 0 else 1)

  parseAndValidateJSON: (config, path) ->
    try
      JSON.parse(config)
    catch err
      throw new Error(path + " does not include a valid JSON object.\n")

  isVersionRequested: (args) ->
    args.version || args.v

module.exports = Pioneer
