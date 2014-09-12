Step Helpers
===========

## Table of contents
* [Freeze](#freeze)
* [Pending](#pending)

###Freeze

Causes process to wait for any key press from the user before proceeding. `@Freeze()` returns a promise that is resolved once the user presses a key.

Can be used from within a step definition with
```coffeescript
@Freeze().then -> ..........
```
Or it can be used via a feature file with
```gherkin
When I Freeze
```

###Pending

Allows you to mark a step as `pending` and not currently implemented. Simply call `@Pending()` from within a step.

```js
this.When(/^I execute a pending step$/, function() {
  this.Pending();
});
```