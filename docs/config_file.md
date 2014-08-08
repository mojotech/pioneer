Configuration File
==================

## Table of Contents
* [Default Configuration](#default-configuratoin)
* [Driver Configuration](#driver-configuration)
* [Error Formatting](#error-formatting)
* [Tags](#tags)
* [Prevent Browser Reload](#prevent-browser-reload)
* [CoffeeScript Step Scaffold](#coffeescript-step-scaffold)

## Default Configuration
If no configuration path is passed in using [--configPath=](docs/command_line.md#configuration-file-path), then pioneer will check to see if the file .pioneer.json exists in the current working directory. If it does not, then the default pioneer configuration is as follows:

```json
{
  "feature": "test/integration/features",
  "require": [
    "test/integration/steps",
    "test/integration/widgets"
  ],
  "format": "./node_modules/pioneer/lib/pioneerformat.js",
  "prevent-browser-reload": true,
  "driver": "phantomjs",
  "error_formatter": "error_formatter.js",
  "coffee": false
}
```

## Driver Configuration

[Driver Configuration Options](docs/command_line.md#driver-configuration)

```json
{
  "driver": "firefox"
}
```

## Error Formatting

```json
{
  "error_formatter": "myDirectory/my_error_formatter.js"
}
```

## Tags
To specify multiple tags, use an array.

```json
{
  "tags": "@myTag"
}
```
```json
{
  "tags": ["@myTag", "@thatTag", "@goodTag"]
}
```

## Prevent Browser Reload

If `prevent-browser-reload` is not declared, then it will default to false.

```json
{
  "prevent-browser-reload": true
}
```

## CoffeeScript Step Scaffold

If `coffee` is not declared, then it will default to false.

```json
{
  "coffee": true
}
```
