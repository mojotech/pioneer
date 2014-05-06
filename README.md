# Dill.js
### Declarative integration tests in javascript (w/ [cucumber](https://github.com/cucumber/cucumber-js) and [chai-as-promised](https://github.com/domenic/chai-as-promised/))
Dill.js provides an abstraction layer between your integration tests and your DOM markup, DRYing up your step definitions and consolidating how people interact with the DOM in tests.

![see it live](http://i.imgur.com/kTjwloS.gif)
[View our Getting Started Guide](docs/getting_started.md) |
[See an example repo.](https://github.com/samccone/dill.js-getting-started)

# Docs
* [Getting Started](docs/getting_started.md)
* [Widget](docs/widget.md)
* [Globals](docs/globals.md)
* [Driver Configuration](#driver-configuration)


## Driver Configuration
You can customize which driver your tests use via the `--driver` command line flag. The default driver is chrome.

See http://selenium.googlecode.com/git/docs/api/javascript/class_webdriver_Capabilities.html for available options.
