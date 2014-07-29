Contributing
=====

* How things fit together[#thepieces]

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



## The Pieces

Development on Pioneer is quite simple and only requires a few steps to get up and going (after you know how the pieces fit together).

<img src="http://i.imgur.com/vS0Zexq.png" width="424px"/>

Pioneer can be quickly understood using this image as a reference.
Pioneer stresses a decoupling of testing components, to enable a developer to quickly change and iterate on their tests.
The highest level component is a `.feature` file. It is in this file that a developer defines (*from the users perspective*) how the webpage should work.

```cucumber
Scenario: Searching for dogs
  When I view google.com
  And I search for "dogs"
  Then I should see 100 results
```

The feature file is read by [cucumber.js](https://github.com/cucumber/cucumber-js) and then looks for matching step definitions to perform the actual assertion and interaction with the webpage.

```js
  this.When(/^I view google.com"$/, function() {
    return this.driver.get("http://google.com")
  });
```

It is from within the step definitions that widgets are created. Widgets are an abstraction layer between the raw [webElement](http://selenium.googlecode.com/git/docs/api/javascript/class_webdriver_WebElement.html) and your `click` or interations.
This abstraction makes refactoring your application code and test code painless, since instead of having to redefine multiple selectors you only have to change one.
If you are familiar with a `backbone.view` a Widget should feel quite similar.

```js
  var MyWidget = Widget.extend({
    root: "div.wow",
    getName: function() {
      return this.read(".name");
    }
  })

  (new MyWidget()).getName().then(function(name) {
    expect(name).to.eql("Sam Jones");
  });
```
