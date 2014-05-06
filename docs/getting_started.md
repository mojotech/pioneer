# Getting Started

_(Taken from our [example repo](https://github.com/samccone/dill.js-getting-started))_

- Require dill.js as a dependency (and install)
  ```json
  "dependencies": {
    "dill": "^0.1.0"
  }
  ```
  ```bash
  npm install
  ```

- Write your features
  `features/search.feature`
  ```gherkin
  Feature: Todo MVC
    Background:
      Given I view todomvc

    Scenario: I add a todo
      When I add a todo "eat apple jacks"
      Then I should see "1" todos
  ```

- Write your step definitions
  `steps/steps.js`
  ```javascript
  module.exports = function() {
    this.Given(/^I view todomvc$/, function() {
      return this.driver.get("http://todomvc.com/labs/architecture-examples/backbone_marionette/")
    });

    this.When(/^I add a todo "([^"]*)"$/, function(text) {
      return new this.Widgets.TodoEntry().add(text);
    });

    this.Then(/^I should see "([^"]*)" todos$/, function(count) {
      new this.Widgets.TodoList().items().should.eventually.have.length(+count);
    });
  }
  ```

- Use dill widgets to abstract your markup from your step definitions
  `widgets/search_form.js`
  ```javascript
  module.exports = function() {
    this.Widgets = this.Widgets || {};

    return this.Widgets.TodoEntry = this.Widget.extend({
      root: '#todoapp',
      add: function(text) {
        return this.find("#new-todo").then(function(elm) {
          elm.sendKeys(text, Driver.Key.ENTER);
        });
      }
    })
  }
  ```
  `widgets/search_results.js`
  ```javascript
  module.exports = function() {
    this.Widgets = this.Widgets || {};

    return this.Widgets.TodoList = this.Widget.List.extend({
      root: '#todo-list',
      itemSelector: 'li'
    });
  }
  ```

- Run your tests (require your steps and widgets)
  ```bash
  ./node_modules/.bin/dill --require steps/ --require widgets/
  ```
