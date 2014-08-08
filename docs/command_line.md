Command Line Options
====================

## Table of Contents
* [Driver Configuration](#driver-configuration)
* [Error Formatting](#error-formatting)
* [Tags](#tags)
* [Prevent Browser Reload](#prevent-browser-reload)
* [CoffeeScript Step Scaffold](#coffeescript-step-scaffold)
* [Configuration File Path](#configuration-file-path)

## Driver Configuration
You can customize which driver your tests use via the `--driver` command line flag. The default driver is chrome.
For example:
* --driver=phantomjs
* --driver=firefox

## Error Formatting
You can customize the format in which your errors are formatted via the `--error_formatter` command line flag. The default format is five lines of the stack trace with a blue first line. To customize the formatter see below

my_formatter.js should export a method like the following

```js
module.exports = function(err) {
  console.log("my custom error formatter", err.stack);
}
```

## Tags
To only run selected features include `--tags=@myTag` and insert @myTag directly before the intended feature(s).

## Prevent Browser Reload
To speed up testing, an optional `--preventReload` flag can be passed to prevent the web driver from restarting after each feature:
  ```bash
  ./node_modules/.bin/pioneer --preventReload=true --require steps/ --require widgets/
  ```

## CoffeeScript Step Scaffold
To have cucumber generate the step scaffold automatically in CoffeeScript, use the optional `--coffee` line flag.
```bash
./node_modules/.bin/pioneer --require steps/ --require widgets/ --coffee
```

## Configuration File Path
Pioneer configuration options can be declared in the form of a JSON file. To declare the path to this file use the optional `--configPath=` flag. Addtional information on the format of this file can be found [here](docs/config_file.md)
```bash
./node_modules/.bin/pioneer --configPath=myConfig.json
```
