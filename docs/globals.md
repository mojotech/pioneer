Globals
=======

## Table of Contents
* [ARGV](#argv)
* [timeout](#timeout)
* [Configuring the Driver](#driver-configuration)

## ARGV

`global.ARGV` is available for those wanting to be able to provide custom command line arguments. `ARGV` contains all command line arguments.

## timeout

`global.timeout` is available for those wanting to adjust the amount of time the driver waits to ensure an element.


## Driver Configuration

If you would like to customize how your selenium driver is built, Pioneer provides a userful method `ConfigureDriver` that you can override to have full control.

```js
module.exports = function() {
  this.ConfigureDriver = function(SeleniumDriver, argv) {
    return new SeleniumDriver.Builder().withCapabilities(SeleniumDriver.Capabilities['chrome']()).build()
  }
}
```

This method can be useful for setting up things like sauce labs. For a detailed walk through on setting up selenium for sauce labs refer to this [article](http://samsaccone.com/posts/testing-with-travis-and-sauce-labs.html).
