Widget
===========

`Widget` is the base class upon which your custom widgets should extend from. The `Widget` class provides you with several helpful utility methods that interact with your DOM in an asynchronous promised based manner.

A simple example of an extension would look like this.

```js
MarketFilters = Widget.extend({
  root: '.market-place-filters',
  setSearchText: function(val) {
    return this.fill(".market-text-search", val);
  }
});
```

All `Widgets` extend from seleniums [WebElement](http://selenium.googlecode.com/git/docs/api/javascript/class_webdriver_WebElement.html)

## Table of contents

* [Api](#api)
  * [Constructing](#constructing)
    * [Finding](#finding)
    * [Extending](#extending)
    * [Overriding](#overriding)
    * [Shorthand](#shorthand)
  * [Root](#root)
  * [Interacting with the DOM](#interacting-with-the-dom)
    * [Click](#click)
    * [Fill](#fill)
    * [sendKeys](#sendkeys)
    * [addClass](#addclass)
    * [removeClass](#removeclass)
    * [toggleClass](#toggleclass)
  * [Querying the DOM](#querying-the-dom)
    * [Read](#read)
    * [Find](#find)
    * [FindAll](#findall)
    * [FindByText](#findbytext)
    * [isPresent](#ispresent)
    * [isVisible](#isvisible)
    * [getAttribute](#getattribute)
    * [getValue](#getvalue)
    * [getText](#gettext)
    * [getInnerHTML](#getInnerhtml)
    * [getOuterHTML](#getOuterhtml)


# API

## Constructing

There are several ways to create a new `Widget` depending on your needs.

### Finding

In most cases the find based factory is going to suit your needs.

`Find` returns a promise-based interface that eventually resolves to a widget with the `el` property already set to a [WebElement](http://selenium.googlecode.com/git/docs/api/javascript/class_webdriver_WebElement.html) instance. It takes a hash of attributes that will be extended onto your object.

```js
Widget.find({
  root: "#big-papa"
}).then(function(widget) {
  // widget.el
  // is the raw WebElement node already found
  // for your convinence.
});
```

### Extending

Extending is simple way to create a new `Class` based on the base `Widget` class via the `.extend` syntax. Extend will override any method or value set on the base `Widget` object.

Using the extend functionality is a handy way to abstraact widget configuration across multiple files and methods into reusable widgets

```js
MyWidget = Widget.extend({
  root: ".biggie-biggie"
});

// Creating a new instance via new
myWidget = new MyWidget({optional: args});

// Creating a new instance via the find factory
MyWidget.find({optional: args}).then(function(widget) {
  myWidget = widget;
});
```

### Overriding

In any `Widgets` contructor you can override the default attributes set on said widget.

This is a handy paradigm to embrace when you have small one-off widgets that do not need custom logic but rather just a few small helper methods and/or properties.

```js
// Creating a new instance with overrides
myWidget = new Widget({optional: args});

// Creating a new instance via the find factory with overrides
Widget.find({optional: args}).then(function(widget) {
  myWidget = widget;
});
```

### Shorthand

A `Widget` can be expressed using the shorthand `W`

```js
myWidget = new W({optional: args})
```

## Root

`root` must be provided in your widget class definition. It scopes all of a widgets DOM lookups to this root element.

The widget's required `root` property allows you to provide a scope on the page with which you are interacting. All operations for your widget will happen within the scope of the element.
It is a common pattern to have multiple widgets represent different parts of the page you are testing (e.g. the login div, the nav div, the form). This allows your widgets to be very focused and succinct.

```js
var PuppySearch = Widget.extend({
  root: '.dog-search',
});
```

## Interacting with the DOM

### Click

`function click(<cssSelector>)...`

`click` simulates a user clicking on the DOM selector that is passed in as a parameter to the function. It returns a promise to let you know when the click has been successful or rejected.

```js
var PuppySearch = Widget.extend({
  root: '.dog-search',
  clickOnTheDog: function() {
    return this.click(".dog");
  }
});
```

### Fill

`function fill(<cssSelector>, <valueToFillWith>)...`

`fill` allows you you to simulate a user filling in an input with a given value. It returns a promise to let you know when the fill has been successful or rejected.

```js
var PuppyNamer = Widget.extend({
  root: '.dog-namer',
  nameDog: function(name) {
    return this.fill(".dog-name", name);
  }
});
```
If only one argument is passed it will fill the root node with the value passed.

```js
var PuppyNamer = Widget.extend({
  root: '.puppy-namer',
  namePuppy: function(name) {
    return this.fill(name);
  }
});
```

### sendKeys

`function sendKeys(<valueToSend>,...)`

`sendKeys` simulates a user typing. Derived from the [Webdriver sendKey method](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/actionsequence.js.src.html).It accepts as many arguments as desired, including special keys such as Driver.Key.ENTER. A list of those special keys can be found at [Selenium WebDriver docs](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/key.js.src.html).

```js
w = new Widget({
  root:"#foo"
})
w.sendKeys("wow", Driver.Key.ENTER)
.then(function(){
  w.read();
}
```

### addClass

`function addClass(<className>)`

`addClass` will add the provided class name to the DOM node of the Widget. It returns a promise that will resolve when the class has been added.

```js
var hidden = new Widget.extend({
  root: '.showing'
})
.addClass('hidden')
```

### removeClass

`function removeClass(<className>)`

`removeClass` will remove the provided class name from the DOM node of the Widget. It returns a promise that will resolve when the class has been removed.

### toggleClass

`function toggleClass(<className>)`

`toggleClass` will toggle the provided class name on the DOM node of the Widget. It returns a promise that will resolve when the class has been toggled.

## Querying the DOM

## Read

`function read(<cssSelector> [,transfomerFunction])...`

`read` allows you to get the "value" attribute or text of a given DOM node. An optional second parameter performs a transformation on the value/text. It returns a promise with the result of the read or rejection.

```js
var PuppyDetails = Widget.extend({
  root: '.puppy-details',
  getName: function(name) {
    return this.read(".dog-name");
  }
});
```

## Find

`function find(<cssSelector>)...`

`find` allows you to find a (single) matching element on the page and grab the resulting DOM node. If a node is not found it will reject the returned promise value, otherwise the promise is resolved with the DOM node.

```js
var PuppyDetails = Widget.extend({
  root: '.puppy-details',
  getInfo: function(name) {
    return this.find(".dog-info");
  }
});
```

## FindAll

`function findAll(<cssSelector>)...`

`findAll` allows you to find a list of matching elements on a page and get an array of the matched DOM nodes. If no elements are found the promise is rejected, otherwise it is resolved with an array of nodes.

```js
var PuppyDetails = Widget.extend({
  root: '.puppy-details',
  getInfoItems: function(name) {
    return this.find(".dog-info li");
  }
});
```

## FindByText

`function findByText(<text>)...`

`findByText` allows you to find the first matching child of the widget. If the element is found then the promise will be resolved with a raw webElement otherwise the promise is resolved with null.

## isPresent

`function isPresent(<selector>)...`

`isPresent` is a utility method to check to see if a given widgets `root` or `root` scoped selector is present on the page.
If the element is found then the promise is successfully resolved with true, otherwise it is resolved with false.

## isVisible

`function isVisible(<selector>)...`

`isVisible` is a utility method to check to see if a given selector is currently visible on the page.
If the element is visible then the promise is resolved with true, otherwise it is resolved with false.

## getAttribute

`function getAttribute(<attribute>)...`

The `getAttribute` method allows you to search an element for a particular attribute. It returns a promise that will resolve with the attribute value if found, otherwise it will resolve with null.
For further reference visit http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/webdriver.js.src.html#l1851

## getValue

`function getValue(<selector>, <transformer>)...`

The `getValue` method lets you get the current value of a given input node. It returns a promise that resolves with the value of the node.

It takes an optional scoping selector, and a transformer.

## getText

`function getText(<selector>)...`

The `getText` method allows you to retrieve the text of a given element. It returns a promise that will resolve with the text if found, otherwise it will resolve with null.

## getInnerHTML

`function getInnerHTML(<selector>)`

The `getInnerHTML` method will retrieve the innerHTML of the selector element. It returns a promise. Proxied off of [innerHTML](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/webdriver.js.src.html#l2016).

## getOuterHTML

`function getOuterHTML(<selector>)`

The `getOuterHTML` method retrives the outerHTML of the selector element. It returns a promise. Proxied off of [outerHTML](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/webdriver.js.src.html#l1997).
