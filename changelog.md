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
