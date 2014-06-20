Contributing
=====

Development on dill.js is quite simple and only requires a few steps to get up and going.

* Install [nodejs](http://nodejs.org)

* Building
  * `$ npm install`.
  * `$ npm run-script build` to build the coffee-script.
  * `$ gulp watch` will automatically rebuild the files when source code changes

* Testing
  * `$ npm run-script integration` to run the integration test suite
  * `$ npm test` to run the unit tests

* Utility
  * `$ npm run-script pub` to release a new version.
  * `$ npm run-script clean` to remove the build coffee-script files.
