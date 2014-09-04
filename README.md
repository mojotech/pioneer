<h1 align="center">Pioneer</h1>

<p align="center">
<img height="200px" width="200px" src="logo.png"/>
</p>
<p align="center">
  <a title='Build Status' href="https://travis-ci.org/mojotech/pioneer">
    <img src='http://img.shields.io/travis/mojotech/pioneer.svg?style=flat-square' />
  </a>
  <a href='https://gitter.im/mojotech/pioneer'>
    <img src='http://img.shields.io/badge/gitter-chat-blue.svg?style=flat-square' alt='Chat' />
  </a>
  <a href='https://coveralls.io/r/mojotech/pioneer'>
    <img src='http://img.shields.io/coveralls/mojotech/pioneer.svg?style=flat-square' />
  </a>
</p>

<h3 align="center"> Integration tests made easy. </h3>

Pioneer provides an abstraction layer between your integration tests and your DOM markup, DRYing up your step definitions and consolidating how people interact with the DOM in tests.

# Installing
  ```bash
  $ npm install pioneer --save-dev
  ```

# Get Started

  Write your features in Cucumber/Gherkin
  ```gherkin
  Scenario: Completing a Todo
    When I enter "Learn Pioneer"
    And complete the first todo
    Then I should see that the first todo is completed
  ```

  Write your step definitions in javascript with promises
  ```js
  this.When(/^complete the first todo$/, function(){
    return new this.Widgets.TodoList().complete(0)
  });

  this.Then(/^I should see that the first todo is completed$/, function() {
    return new this.Widgets.TodoList()
    .isCompleted(0).should.eventually.eql(true)
  });
  ```

  Abstract your application's components and interactions into reusable widgets
  ```js
  module.exports = function() {
    this.Widgets = this.Widgets || {};

    Widgets.TodoList = new this.Widget.extend({
      root: "#todo-list",

      complete: function (index) {
        return this.clickAt({
          selector: "input",
          index: index
        })
      },

      isCompleted: function(index) {
        this.at(index).then(function(el){
          el.getAttribute("class").then(function(className){
            return className.indexOf("completed") > -1
          })
        })
      }

    })
  }
  ```

  Load your dependencies and config into `pioneer.js`
  ```json
  {
    "feature": "features/",
    "require": [
      "step_definitions",
      "widgets/"
    ],
    "format": "pioneerformat.js",
    "driver": "chrome",
    "error_formatter": "errorformat.js",
    "preventReload": false,
    "coffee": false
  }
  ```

  And run your tests
  ```bash
  $ ./node_modules/.bin/pioneer
  ```

### [(Read the full getting started guide)](docs/getting_started.md)

# Docs

* [Global Variables](docs/globals.md)
* [Widget](docs/widget.md)
* [Widget.List](docs/list.md)
* [Widget.Form](docs/form.md)
* [Step Helpers](docs/step_helpers.md)
* [Command Line Options](docs/command_line.md)
* [Configuration File](docs/config_file.md)
