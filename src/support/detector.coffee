exec = require('child_process').exec
argv = require('optimist').argv
require('colors')

output = (err) ->
  if err
    console.log "Error: You are missing ChromeDriver. \n".red+
                "       Please download the latest version of ChromeDriver here \n".red +
                "       http://chromedriver.storage.googleapis.com/index.html".red
    false
  else
    true

module.exports =
  supportsDriver: (cb) ->
    if argv.driver == undefined || argv.driver == 'chrome'
      exec 'which chromedriver', (err) ->
        output.apply(@, arguments)
        cb(!!err)
    else
      cb(false)
