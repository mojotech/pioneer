fs           = require 'fs'
path         = require 'path'
scaffold     = require './scaffold_builder.js'
_            = require 'lodash'

CONFIG_NAMES = [
  "tags",
  "feature",
  "require",
  "format",
  "error_formatter",
  "coffee",
  "driver",
  "preventReload",
  "scaffold"
]

CUCUMBER_FORMATTERS = [
  "pretty",
  "progress",
  "json",
  "summary"
]

module.exports =
  convertToExecOptions: (objArry, libPath) ->
    execOptions =
      _.map objArry, (val) =>
        k = _.keys(val)[0]

        switch
          when k is 'tags'
            if typeof val[k] is 'string'
              "--#{k}=".concat(
                (_(Array::concat(val[k]))
                .flatten()
                .value())
                .join(", "))
            else
              val[k].map (item, index) ->
                "--#{k}=#{item}"

          when k is 'driver'
            process.argv.push "--driver=#{val[k]}"
            ""

          when k is 'coffee'
            if val[k]
              "--#{k}"
            else
              ""
          when k is "format"
            v = val[k]
            if @isCucumberFormatter(v)
              "--format=#{v}"
            else if fs.existsSync(p = path.join(process.cwd(), v))
              "--format=#{p}"
            else
              "--format=#{path.join(libPath, v)}"


          when k is 'preventReload'
            v = val[k]
            switch
              when typeof(v) is "string"
                if(v == "true")
                  process.argv.push("--prevent-browser-reload")
                ""

              else
                if(val[k])
                  process.argv.push("--prevent-browser-reload")
                ""

          when k is 'feature'
            val[k] = Array::concat(val[k])

          when k is 'require'
            val[k].reduce((p, v) ->
              p.concat("--require", v)
            , [])

          else
            if k?
              "--#{k}=#{val[k]}"
            else
              ""

    _(["--require", path.join(libPath, "support")])
    .concat(execOptions)
    .flatten()
    .compact()
    .tap( (arr) -> arr.splice(0, 0, null, null))
    .value()

  generateOptions: (minimist, config, libPath) ->
    options =
    _(CONFIG_NAMES)
    .map((name) ->
      obj = {}

      if (minimist[name]?)
        obj[name] = minimist[name]
        if name is 'require' and config[name]?
          obj[name] = Array::concat(obj[name]).concat(config[name])
      else if config[name]?
        obj[name] = config[name]

      if obj[name]? then obj else null
    )
    .compact()
    .value()

    if(!@hasFeature(options))
      if(fs.existsSync(path.join(process.cwd(), '/features')))
        @convertToExecOptions(options, libPath)
      else
        if(!!minimist["_"].length)
          options.push({feature: minimist["_"]})
          @convertToExecOptions(options, libPath)
        else
          scaffold.featureNotSpecified()
          return null
    else
      @convertToExecOptions(options, libPath)

  hasFeature: (options) ->
    r = false
    _.forEach options, (opt) =>
        k = _.keys(opt)[0]
        if(k == 'feature')
          r = true

    r

  isCucumberFormatter: (formatter) ->
    !!(_.find(CUCUMBER_FORMATTERS, (f) -> f is formatter))
