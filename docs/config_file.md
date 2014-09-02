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
If no configuration path is passed in using [--configPath=](docs/command_line.md#configuration-file-path), then pioneer will check to see if the file `pioneer.json` exists in the current working directory.

## Driver Configuration

```json
{
  "driver": "firefox"
}
```

http://selenium.googlecode.com/git/docs/api/javascript/class_webdriver_Capabilities.html

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

If `preventReload` is not declared, then it will default to false.

```json
{
  "preventReload": true
}
```

## CoffeeScript Step Scaffold

If `coffee` is not declared, then it will default to false.

```json
{
  "coffee": true
}
```
