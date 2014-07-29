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
