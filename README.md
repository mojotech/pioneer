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
``` bash
$ npm install pioneer --save-dev
```

# Get Started

### Make your first test
``` bash
$ ./node_modules/.bin/pioneer --scaffold
```

This will give you

* A Gherkin feature file

``` gherkin
Feature: Simple Feature

  Background:
    Given I visit TODOMVC

  Scenario: Entering Information
    When I enter "dogecoins"
    Then I should see "dogecoins"
```

* Step definitions with promises and widgets

``` js
this.Given(/^I visit TODOMVC$/,function(){
  this.driver.get('http://todomvc.com/architecture-examples/backbone/')
});

this.When(/^I enter \"([^\"]*)\"$/, function(value){
  new this.Widget({
    root: "#new-todo"
  }).sendKeys(value,'\uE007');
});

this.Then(/^I should see \"([^\"]*)\"$/, function(expected){
  var List = this.Widget.List.extend({
    root: "#todo-list",
    childSelector: "li"
  })

  return new List().readAt(0).should.eventually.eql(expected);
})
```

* Plus some basic directory structure and configuration

### Run it!
``` bash
$ ./node_modules/.bin/pioneer
```

### [Now, write your second test!](docs/getting_started.md)

# Docs

* [Global Variables](docs/globals.md)
* [Widget](docs/widget.md)
* [Widget.List](docs/list.md)
* [Widget.Form](docs/form.md)
* [Step Helpers](docs/step_helpers.md)
* [Command Line Options](docs/command_line.md)
* [Configuration File](docs/config_file.md)
