Globals
===========

Dill.js provides several helpful objects in the global scope to aid you in your development.


## Table of contents

* [Helpers](#helpers)
  * [$](#$)
  * [_](#_)
  * [Driver](#driver)
  * [Argv](#argv)

# Helpers

## $

`$` is a reference to the webdriver [promise library](http://selenium.googlecode.com/git/docs/api/javascript/namespace_webdriver_promise.html).

## _

`_` is a reference to [lodash](http://lodash.com/docs).

## Driver

`Driver` is a reference to [selenium driver namespace](http://selenium.googlecode.com/git/docs/api/javascript/namespace_webdriver.html).

## Argv

`argv` is a reference to all the process arguments that you pass.
Argument parsing is provided by [node-optimist](https://github.com/substack/node-optimist).
