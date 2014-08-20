fs           = require 'fs'
path         = require 'path'
readlineSync = require 'readline-sync'
color        = require 'colors'
_            = require 'lodash'

module.exports =
  featureNotSpecified: ->
    ans = readlineSync.question("You did not specify a feature path. Would you like Pioneer to generate one for you? y/n\n")
    if(['y', 'yes'].indexOf(ans.toLowerCase()) > -1)
      @createScaffold()
    else
      console.log('Looks like you have no feature files or have not passed the path to them. http://www.github.com/mojotech/pioneer/docs')
    process.exit()

  createScaffold: (options) ->
    p = path.join(process.cwd(), '/tests')
    if(!fs.existsSync(p))
      fs.mkdirSync(p)
    features = path.join(p, '/features')
    if(!fs.existsSync(features))
      fs.mkdirSync(features)
    fixtures = path.join(p, '/fixtures')
    if(!fs.existsSync(fixtures))
      fs.mkdirSync(fixtures)
    widgets = path.join(p, '/widgets')
    if(!fs.existsSync(widgets))
      fs.mkdirSync(widgets)
    steps = path.join(p, '/steps')
    if(!fs.existsSync(steps))
      fs.mkdirSync(steps)
    fs.writeFileSync(path.join(features, 'simple.feature'), fs.readFileSync(path.join(__dirname, "scaffold/simple.txt"), 'utf8'))
    fs.writeFileSync(path.join(steps, 'simple.js'), fs.readFileSync(path.join(__dirname, "scaffold/simple.js"), 'utf8'))
    hiddenPioneer = path.join(process.cwd(), '/pioneer.json')
    if(!fs.existsSync(hiddenPioneer))
      fs.writeFileSync(hiddenPioneer, fs.readFileSync(path.join(__dirname, "scaffold/example.json"), 'utf8'))
    else
      @askToOverWrite(hiddenPioneer, fs.readFileSync(path.join(__dirname, "scaffold/example.json"), 'utf8'))
    @_logCompleted()

    process.exit()

  askToOverWrite: (file, data) ->
    ans = readlineSync.question("It looks like you already have a" + file + "file, are you sure that you would like to overwrite this? y/n\n")
    if(['y', 'yes'].indexOf(ans.toLowerCase()) > -1)
      fs.writeFileSync(file, data)
    else
      console.log("You chose not to overwrite" + file + ", to run the scaffold files include tests/features in the feature option of your config files.")

  _logCompleted: ->
    console.log('Scaffold created. You may now run your first test'.inverse.green)
