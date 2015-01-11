Command Line Options
====================

## Table of Contents
* [Driver Configuration](#driver-configuration)
* [Error Formatting](#error-formatting)
* [Tags](#tags)
* [Prevent Browser Reload](#prevent-browser-reload)
* [CoffeeScript Step Scaffold](#coffeescript-step-scaffold)
* [Configuration File Path](#configuration-file-path)
* [Scaffold Creation](#scaffold-creation)
* [Version](#version)

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
  ./node_modules/.bin/pioneer --preventReload=true
  ```

## CoffeeScript Step Scaffold
To have cucumber generate the step scaffold automatically in CoffeeScript, use the optional `--coffee` line flag.
```bash
./node_modules/.bin/pioneer --coffee
```

## Configuration File Path
Pioneer configuration options can be declared in the form of a JSON file. To declare the path to this file use the optional `--configPath=` flag. Addtional information on the format of this file can be found [here](config_file.md)
```bash
./node_modules/.bin/pioneer --configPath=myConfig.json
```

## Scaffold Creation
Pioneer can generate a scaffold for your first tests automatically using the optional `--scaffold` command line flag. This generates a tests/ directory, with features/, steps/ and widgets/. It creates simple.feature and simple.js files that include your first Pioneer test! It also creates a `pioneer.json` file in your current working directory. This config file automatically includes the created feature files, and the following information:
```json
{
  "feature": "tests/features",
  "require": [
    "tests/steps",
    "tests/widgets"
  ],
  "format": "pioneerformat.js",
  "driver": "chrome",
  "error_formatter": "errorformat.js",
  "preventReload": false,
  "coffee": false
}
```

## Verbosity
You can show some extra information about the test run by setting the `--verbose` flag. This can be used to override the value in the config file. You will need to use `--verbose=false` to turn off verbosity that has been set in the config file.

## Version

You can display the current version of Pioneer that you are using by passing the optional `--version` or `-v` command line flag.
