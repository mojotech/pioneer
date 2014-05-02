Dill.js
=====

Dill.js provides an abstraction layer between your integration tests and your DOM markup, DRYing up your step definitions and consolidating how people interact with the DOM in tests.


# Docs
* [Widget](docs/widget.md)
* [Globals](docs/globals.md)
* [Driver Configuration](#driver-configuration)


## Driver Configuration
You can customize which driver your tests use via the `--driver` command line flag. The default driver is chrome.

See http://selenium.googlecode.com/git/docs/api/javascript/class_webdriver_Capabilities.html for available options.
