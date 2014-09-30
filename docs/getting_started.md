# Getting Started

- Require Pioneer as a dependency (and install)

```bash
$ npm install pioneer --save
```

- Setup your testing directory

```bash
$ ./node_modules/.bin/pioneer --scaffold
```

- Run your first Pioneer test!

```bash
$ ./node_modules/.bin/pioneer
```

- Expanding on your tests


  Now that you've run your first test, you are ready to add another one.
  To add another feature to your test, add the following to the end of the `test/features/simple.feature`

```gherkin
Scenario: Completing a Todo
  When I enter "Learn Pioneer"
  And complete the first todo
  Then I should see that the first todo is completed
```

  This will create another test that enters a new todo, clicks complete and then tests to ensure that the first todo is completed.

  If you ran

```bash
$ ./node_modules/.bin/pioneer
```

  right now, you would notice that you did not define step definitions for the second and third step of the "Completing a Todo" scenario.

  Pioneer will catch these undefined steps, and automatically generate a suggestion for that step.

  In this case, pioneer would generate something that looks like this:

  You can implement step definitions for undefined steps with these snippets:

```js
this.When(/^complete the first todo$/, function() {
  // express the regexp above with the code you wish you had
});

this.Then(/^I should see that the first todo is completed$/, function() {
  // express the regexp above with the code you wish you had
});
```

  Instead of adding that suggestion, you should append `tests/steps/simple.js` with the following

```js
this.When(/^complete the first todo$/, function(){
  return new this.Widget.List({
    root: "#todo-list"
  })
  .clickAt({
    index: 0,
    selector: "input"
  })
});

this.Then(/^I should see that the first todo is completed$/, function() {
  return new this.Widget.List({
    root: "#todo-list"
  })
  .at(0).then(function(el){
    return el.hasClass("completed").should.eventually.be.true;
  });
});
```

  To explain what these steps are doing:
   - First we create a new widget around the element `#todo-list` and click on the input in the first `<li>`. This is how one completes a todo.
   - To ensure that the todo was completed, we then check the class on the first `<li>` element of `#todo-list` to make sure that the class "completed" was added.

- Making your tests more efficient


  And there you have it, you wrote your first test using Pioneer! Easy right? But believe it or not, creating your step definitions is even easier if you take advantage of abstracting your own custom Widgets.

  Now create the file `tests/widgets/my_widget.js` and append the following:

```js
module.exports = function(){
  this.Widgets = this.Widgets || {};

  this.Widgets.TodoList = this.Widget.List.extend({
    root: "#todo-list",

    complete: function (index) {
      return this.clickAt({
        selector: "input",
        index: index
      })
    },


    isCompleted: function(index) {
      return this.at(index).then(function(el){
        return el.hasClass("completed");
      });
    }
  })
}
```

  You have now extracted the complicated logic of checking list items out into a seperate file which can easily be reused. Now your step definitions can look list this

```js
this.When(/^complete the first todo$/, function(){
  return new this.Widgets.TodoList().complete(0)
});

this.Then(/^I should see that the first todo is completed$/, function() {
  return new this.Widgets.TodoList()
  .isCompleted(0).should.eventually.eql(true)
});
```
