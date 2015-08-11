### v0.11.6 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.11.5...v0.11.6)

* Fix release issue

### v0.11.5 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.11.4...v0.11.5)

#### Updates

* Update selenium-webdriver to 2.46.1

### v0.11.4 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.11.3...v0.11.4)

#### Updates

* Update selenium-webdriver to 2.45.1

#### Fixes

* Add shrinkwrap to lock dependencies.

### v0.11.3 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.11.2...v0.11.3)

#### Fixes

* Fixed a bug where it was impossible to pass multiple feature arguments via the command line.

### v0.11.2 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.11.1...v0.11.2)

#### Updates

* Users can now opt out of notifications.
* Allow for users to override the driver build phase. This allows users to use tools like sauce labs and other hosted selenium services.
* Minor Doc uodates

### v0.11.1 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.11.1...v0.11.1)

#### Updates

* Update selenium-webdriver version to use the latest and greatest version.

### v0.11.0 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.10.5...v0.11.0)

#### Features

* `Driver` is now exposed on the world.

* `getItemClass` is now available to lookup a `itemClass` at instantiation time of a List.

*  Finding by text now respects the internal global.timeout instead of failing right away.

* Test runs now have a clean output options (omitting message about the configPath)

* Enable the ability to toggle the visibility of the extra test run output, such as duration.

#### Fixes

* Update chai version to fix peer dependency issue
* Update todo mvc test link
* Doc consistency fixes

### v0.10.5 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.10.4...v0.10.5)

#### Fixes

* Pioneer bin file is now hardened for windows environments.

### v0.10.4 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.10.3...v0.10.4)

#### Features

Allow pioneer to be run with command line args alone.

`pioneer features --require=steps --require=widgets` now will work.

### v0.10.3 [view commit logs](https://github.com/mojotech/pioneer/compare/v0.10.2...v0.10.3)

#### Features

* You are now able to mark steps as `pending` using the `this.Pending()` syntax.

#### Windows Support

* Pioneer, now works under windows.

### v0.10.2[view commit logs](https://github.com/mojotech/pioneer/compare/v0.10.1...v0.10.2)

#### Widget.list

* The list widget now has a has a `length` method to enable simple assertions about the number of child items.

#### Cleanups

* Fix broken links and typos across repo.

### v0.10.1[view commit logs](https://github.com/mojotech/pioneer/compare/v0.10.0...v0.10.1)

#### Fixes

* Fix broken `findAll` list el instantiation.

### v0.10.0[view commit logs](https://github.com/mojotech/pioneer/compare/v0.9.0...v0.10.0)

#### Breaking Changes

* `findAll` allows you to find a list of matching elements on a page. It returns a promise that resolves with a new [Widget List](docs/list.md) with the same root as the widget that invoked `findAll`. The `itemSelector` of the new `Widget.List` will be the selector argument passed.

* `submitSelector` no longer takes a node input. If you would like to use a submit selector other than `[type="submit"]` then you can override the `submitSelector` method

#### Widget.Form

* `readAll` now calls `getValue` on each field as opposed to `read`

### v0.9.0[view commit logs](https://github.com/mojotech/pioneer/compare/v0.8.2...v0.9.0)

#### Breaking Changes

* Widget `fill` method now clears the element before sending the value
* Pioneer no longer looks for a `.pioneer.json` file to read configuration options from. Instead it will look for a `pioneer.json` file.

#### Widget

###### Helpers

* `hasClass` will test the existence of the provided class name on the DOM node of the Widget. It takes a hash that can contain an optional selector. If you only pass a string to the method and not an object then it will use the string as the class name. It returns a promise that will resolve with `true` or `false`.

* `sendKeys` now supports hash style arguments, including an optional selector.

* `clear` calls the webdriver [clear](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/webdriver.js.src.html) method. It takes a hash that supports an optional selector to scope the `clear` operation. If only a string is passed to clear, and not an object then it will use it as a selector for the `find` operation. It returns a promise that resolves with a widget.

```js
new this.Widget({
  root: “.some-div”
}).sendKeys({
  selector: “input”,
  keys: [
    "wow",
    Driver.Key.SPACE,
    "pioneer",
    Driver.Key.ENTER
  ]
})
```

###### Static Methods

* Static methods can be used for situations where you do not want to declare a new Widget to do something.
* Static methods introduced for the following widget helpers:
  - click
  - fill
  - hover
  - doubleClick
  - read
  - isPresent
  - isVisible
  - getAttribute
  - getValue
  - getText
  - getInnerHTML
  - getOuterHTML
  - hasClass
  - sendKeys
  - clear


#### Command Line Flags

* Version: `--version` or `-v` may now be passed to display the current version of Pioneer

#### Driver

* `driver.visit` aliased to `driver.get`

#### Format

* pioneer format no longer displays the filename and line number of each scenario and step. Instead it will display the feature file at the beginning of each feature

### v0.8.2[view commit logs](https://github.com/mojotech/pioneer/compare/v0.8.1...v0.8.2)

#### Fixes

* Fix incorrect exit code on failure

### v0.8.1[view commit logs](https://github.com/mojotech/pioneer/compare/v0.8.0...v0.8.1)

#### Fixes

* Fix bug where `isPresent` would fail when the widget was constructed via an `el` based constructor.

* Fix broken multi-tag formatter.

#### New

* Added a global `timeout` to adjust how long a step will wait before failing.

* Added a new gloabl `ARGV` to give you access to the raw `process.argv` passed into the process.

### v0.8.0[view commit logs](https://github.com/mojotech/pioneer/compare/v0.7.2...v0.8.0)

#### Breaking Changes
* Removed global variables (`$`, `Driver`, ` _`,  `argv`)

* `read` no longer supports multiple arguments. Changed to hash-style arguments
* `findByText` removed. To find by text use the optional “text” key on the `find` method
* `fill` no longer supports multiple arguments. Changed to hash-style arguments
* `getValue` no longer supports multiple arguments. Changed to hash-style arguments

* `clickAt` no longer supports multiple arguments. Changed to hash-style arguments
* `readAt` no longer supports multiple arguments. Changed to hash-style arguments

###### Widget

* New shorthand declaration via `this.W` from `this.Widget`
* Methods now support hash-style arguments for instance…..

```js
return new this.Widget({
  root: “div”
})
.fill({
  selector: “input”,
  value: [“Pioneer” Driver.Key.SPACE, “is”, Driver.Key.SPACE, “awesome!”]
});
```

#### Helpers

* `addClass`, `removeClass`, `toggleClass` now accepts an optional selector to allow scoping within the widget
* `getAttribute` - now accepts an optional selector to allow scoping within the widget
* `isVisible` - will first check to see if an element is present and return false if it is not.
* `hover` - the `Hover` method on a widget takes the same params as find to locate the DOM node to be hovered. It returns a promise that is resolved with the widget after the mouse has been moved over the target element. If you do not pass anything to hover it will hover over the widgets root node.
* `doubleClick` - the `doubleClick` method on a widget takes the same params as [find](#find) to locate the DOM node to be doubleClicked. It returns a promise that is resolved with the widget after the mouse has been doubleClicked on the target element. If you do not pass anything to doubleClick it will double click the root node of the widget.

#### Widget.Fields
Fields Is now removed as being a base class. Its methods have been moved within `Widget.Form`

#### Widget.List

*  `select` can be used to select an option from a dropdown menu. It takes a hash with an optional `<selector>` in which you can specifiy either `<text>` or `<value>` to select by. Specifiying both text and a value will result in an error. It returns a promise that will resolve with null.

<needs a code example>
```html
<div class="form2">
  <select>
    <option value="one">Option Number 1</option>
    <option value="two">Option Number 2</option>
    <option value="three">Option Number 3</option>
  </select>
</div>
```

```js
return new this.Widget.Form({
  root: "form2"
})
.select({
  selector: "select",
  value: "three"
})

//Resulting in the selection of the option with a value of "three".
```

* `invoke` - arguments to pass to the invoking method can now be passed using an object


#### Scaffolding

Pioneer can generate a scaffold for you to build your suite on via the newly added`--scaffold` command line flag.

Scaffold generates a tests/ directory, with features/, steps/ and widgets/. It creates simple.feature and simple.js files that include your first Pioneer test! It also creates a .pioneer.json file in your current working directory.

The option to generate a scaffold is also presented if Pioneer is called without specifying a feature file.

#### Configuration

* Pioneer no longer has a default configuration. A similar goal can be accomplished via a `.pioneer.json` within the directory that you run your tests from.

### v0.7.2[view commit logs](https://github.com/mojotech/pioneer/compare/v0.7.1...v0.7.2)

#### Fixes

* Move bluebird dep out of dev dependencies.

### v0.7.1[view commit logs](https://github.com/mojotech/pioneer/compare/v0.7.0...v0.7.1)

#### Fixes

* Fix issue with output formatter path lookup.

### v0.7.0[view commit logs](https://github.com/mojotech/pioneer/compare/v0.6.3...v0.7.0)

#### Widget

##### Accessors

* getValue - The `getValue` method lets you get the current value of a given input node. It returns a promise that resolves with the value of the node.

* read - No longer to be used with input fields (was extracted to `getValue`)

* getInnerHTML - Returns a promise that resolves with the innerHTML of the selector element.

* getOuterHTML - Returns a promise that resolves with  the outerHTML of the selector element.

##### Helpers

* addClass
* removeClass
* toggleClass

#### Widget.List

##### Helpers

* clickAt - `clickAt` is a combination of the at method that allows clicking on a certain index of list. The optional `<selector>` parameter allows for scoping within index. It returns a promise that is resolved when the index has been clicked.

* readAt - `readAt` is a combination of the at method and the read method and allows for scoping within an el at the given index. The optional `<selector>` parameter allows for scoping within index. There is also an optional transformer argument that mirrors the default read implementation. Read at
returns a promise that resolves with the value of read

* each - Returns a promise that resolves with the list items after each item in the list has been iterated over. The iterator method receives two arguments, the widget instance and the index of the item being iterated over.

* invoke - Returns a promise that resolves when the specified method has been invoked on all children.

#### Docs

* Added missing documentation for forms and fields

#### Configuration

Configuring pioneer options can now be done using a JSON file. If no configuration path is passed in using `--configPath=`, then pioneer uses the [default configuration settings](https://github.com/mojotech/pioneer/blob/master/docs/config_file.md#default-configuration).

Pioneer will also look for a .pioneer.json file in the directory that you invoke the command from.

The `--prevent-browser-reload` flag is no longer valid, it has been changed to `--preventReload=true`. From configuration it can be specified as { “preventReload”: true }

#### Cleanup

* Remove Pioneer.Iframe from core - https://github.com/mojotech/pioneer.iframe
* Remove Pioneer.View from core - https://github.com/mojotech/pioneer.marionette
* Integration features/steps separated out to several files

#### Formatting

Pioneer now has its own format type that is uses by default. This formatter changed the way in which the test summary is displayed. Failing steps will now be accompanied by the feature file and line number that they correspond with.


### v0.6.3[view commit logs](https://github.com/mojotech/pioneer/compare/v0.6.2...v0.6.3)

  * Fixes

    * Fix broken bin path

### v0.6.2[view commit logs](https://github.com/mojotech/dill.js/compare/v0.6.1...v0.6.2)

  * Features
    * Add proxy `getInnerHTML` on the widget class.
    * Add proxy `getOuterHTML` on the widget class.

  * Fixes
      * Fix broken `at` selector for lists.


### v0.6.1[view commit logs](https://github.com/mojotech/dill.js/compare/v0.6.0...v0.6.1)

  * Fixes
      * fix xpath `findByText` relative selector bug.

### v0.6.0[view commit logs](https://github.com/mojotech/dill.js/compare/v0.5.0...v0.6.0)

  * Features
    * Forms now default to `form` for their root selector.
    * `getText` is now available on Widgets.
    * `sendKeys` is now available on Widgets.
    * The `fill` method now takes one or two arguments. When only passed a single argument will default to filling the widgets root node with the passed argument.

  * Refactors
    * Invoke cucumber programatically vs via an exec.
    * General Doc improvements

### v0.5.0[view commit logs](https://github.com/mojotech/dill.js/compare/v0.4.1...v0.5.0)

  * Features
    * `isVisible` is now available on a widget.
    * `findByText` is now available on a widget to enable you to lookup children of a widget based on arbitrary text content.
    * `getAttribute` is now available on a widget, for reading a single attribute of a node.
    * `findWhere` is now available on a `Dill.List` widget for finding a single `webElement` based on a filter method.
    * `Iframe` Widget was added for interacting with iframes and switching focus in and out of them.
    * You can now disable the reloading of the browser instance between tests via the `--prevent-browser-reload` CLI flag.
    * Error stacktraces are now limited to 5 lines.
    * A `freeze` utility method and step definition were added for aiding debugging. The freeze method prevents the steps from continuing until the user presses a key in the terminal.

  * Fixes
    * Widget.list children lookup no longer uses the broken `nth` child based selector.

### v0.4.1[view commit logs](https://github.com/mojotech/dill.js/compare/v0.4.0...v0.4.1)

  * Features
    * `isPresent` takes an optional CSS selector to further scope the lookup.
    * `Read` takes an additional transformer method to mutate the read result.

  * Selenium WebDriver
    * Bump version to fix two bugs introduced in ChromeDriver
      * FIXED: 7300: Connect to ChromeDriver using the loopback address since
      * FIXED: 7465: Fixed `net.getLoopbackAddress` on Windows

### v0.4.0 [view commit logs](https://github.com/mojotech/dill.js/compare/v0.3.0...v0.4.0)

  * Widget
    * Add `getHtml` method.
    * Add a `find` based constructor to widgets that return a promise and resolves as a new widget with a pre found `webElement` instance under the `el` property. Thus preventing you from having to do a `find` to interact with the widgets DOM.

  * Widget.List
    * Add `map` method to list to interact with each item.
    * Add `filter` method to reduce items by a filter method.
    * Add `at` method to get an item at a given index.

  * Widget.View
    * Add a new widget type that integrates in with `Marionette` Views.

  * Tests
    * Add integration test coverage for dill.js.

  * General
    * Split widget files into seperate files.

### v0.3.0 [view commit logs](https://github.com/mojotech/dill.js/compare/v0.2.0...v0.3.0)

* Fixes
  * Remove the automatic inclusion of the features directory. This was forcing projects to always have a feature directory relative to where the tests were run from.

### v0.2.0 [view commit logs](https://github.com/mojotech/dill.js/compare/v0.1.1...v0.2.0)

* Fixes
  * Extend syntax now correctly sets instance properties. This is a breaking change if you were unknowingly depending on the broken functionality.

* Features
  * Tests now display total runtime after running.

### v0.1.1 [view commit logs](https://github.com/mojotech/dill.js/compare/v0.1.0...v0.1.1)

* Features
  * You can now specify which driver dill.js uses when running tests via the --driver command line flag.
