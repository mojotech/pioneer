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
