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
  * [Static Methods](#static-methods)
    * [click](#static-click)
    * [fill](#static-fill)
    * [hover](#static-hover)
    * [doubleClick](#static-doubleclick)
    * [read](#static-read)
    * [isPresent](#static-ispresent)
    * [isVisible](#static-isvisible)
    * [getAttribute](#static-getattribute)
    * [getValue](#static-getvalue)
    * [getText](#static-gettext)
    * [getInnerHTML](#static-getinnerhtml)
    * [getOuterHTML](#static-getouterhtml)
    * [hasClass](#static-hasclass)
    * [sendKeys](#static-sendkeys)
    * [clear](#clear)
  * [Interacting with the DOM](#interacting-with-the-dom)
    * [click](#click)
    * [fill](#fill)
    * [hover](#hover)
    * [doubleClick](#doubleclick)
    * [sendKeys](#sendkeys)
    * [addClass](#addclass)
    * [removeClass](#removeclass)
    * [toggleClass](#toggleclass)
    * [clear](#clear)
  * [Querying the DOM](#querying-the-dom)
    * [read](#read)
    * [find](#find)
    * [findAll](#findall)
    * [isPresent](#ispresent)
    * [isVisible](#isvisible)
    * [getAttribute](#getattribute)
    * [getValue](#getvalue)
    * [getText](#gettext)
    * [getInnerHTML](#getinnerhtml)
    * [getOuterHTML](#getouterhtml)
    * [hasClass](#hasclass)


# API

## Constructing

There are several ways to create a new `Widget` depending on your needs.

### Finding

In most cases the find based factory is going to suit your needs.

`find` returns a promise-based interface that eventually resolves to a widget with the `el` property already set to a [WebElement](http://selenium.googlecode.com/git/docs/api/javascript/class_webdriver_WebElement.html) instance. It takes a hash of attributes that will be extended onto your object.

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

Using the extend functionality is a handy way to abstract widget configuration across multiple files and methods into reusable widgets

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
myWidget = new this.Widget({optional: args});

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

## Static Methods

Static methods can be used for situations where you do not want to declare a new Widget to do something. Static methods ALWAYS require selectors, otherwise Pioneer won't know what you want to operate on!

These methods allow you to do simple operations with less code.
For example:

```js
new this.Widget({
  root: "#that-button"
}).click()
```

can be simplified to:

```js
this.Widget.click({selector: "#that-button"})
```

### static click

Static implementation of [click](#click)

### static fill

Static implementation of [fill](#fill)

```js
this.W.fill({
  selector: ".field1",
  value: ["such good text", Driver.Key.ENTER]
})
```

### static hover

Static implementation of [hover](#hover)

```js
this.W.hover({
  selector: "#your-target"
})
```

### static doubleClick

Static implementation of [doubleClick](#doubleclick)

```js
this.W.doubleClick({
  selector: "#some-target"
})
```

### static read

Static implementation of [read](#read)

```js
this.W.read({
  selector: "p.third",
  transformer: function(text){
    text.toUpperCase()
  }
})
```

### static isPresent

Static implementation of [isPresent](#ispresent) not the element is present.

```js
this.W.isPresent({
  selector: "body"
})
```

### static isVisible

Static implementation of [isVisible](#isvisible) not the element is visible.

```js
this.W.isVisible({
  selector: ".hidden"
})
```

### static getAttribute

Static implementation of [getAttribute](#getattribute)

```js
this.W.getAttribute({
  selector: "img.thumb",
  attribute: "width"
})
```

### static getValue

Static implementation of [getValue](#getvalue)

```js
this.W.getValue({
  selector: ".field2"
})
```

### static getText

Static implementation of [getText](#gettext)

```js
this.W.getText({
  selector: "p.fifth"
})
```

### static getInnerHTML

Static implementation of [getInnerHTML](#getinnerhtml)

```js
this.W.getInnerHTML({
  selector: ".some-div"
})
```

### static getOuterHTML

Static implementation of [getOuterHTML](#getouterhtml)

```js
this.W.getOuterHTML({
  selector: "#container"
})
```

### static hasClass

Static implementation of [hasClass](#hasclass)

```js
this.W.hasClass({
  selector: "li.active",
  className: "inactive"
})
```

### static sendKeys

Static implementation of [sendKeys](#sendkeys)

```js
this.W.sendKeys({
  selector: ".username",
  keys: "pioneer_expert"
})
```

### static clear

Static implementation of [clear](#clear)

```js
this.W.clear({
  selector: ".password"
}).then(function(widget){
  ...
})
```

## Interacting with the DOM

### click

`function click({selector:<cssSelector>})...`

`click` simulates a user clicking on the DOM selector that is passed in as a parameter to the function. It returns a promise to let you know when the click has been successful or rejected.
If only a string is passed, and not an object, it will parse it as a selector.

```js
var PuppySearch = Widget.extend({
  root: '.dog-search',
  clickOnTheDog: function() {
    return this.click(".dog");
  }
});
```

### fill

`function fill({selector:<cssSelector>, value: valueToFillWith})...`

`fill` allows you you to simulate a user filling in an input with a given value. It returns a promise to let you know when the fill has been successful or rejected.
`fill` takes a hash of options including an optional selector, and a required value to send to the widget. If only an array is passed, it will fill the root with that array.

```js
var name = ['Jack ', 'the ', 'Ripper', Driver.Enter]
var PuppyNamer = Widget.extend({
  root: '.dog-namer',
  nameDog: function(name) {
    return this.fill({
      selector: ".dog-name",
      value: name
    });
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

### hover

`function hover({find options})...`

the `hover` method on a widget takes the same params as [find](#find) to locate the DOM node to be hovered. It returns a promise that is resolved with the widget after the mouse has been moved over the target element. If you do not pass anything to hover it will hover over the widgets root node.

```js
new this.Widget({
  root: "h4"
})
.hover().then(function(widget) {
  //...
})
```

### doubleclick

`function doubleClick({find options})...`

the `doubleClick` method on a widget takes the same params as [find](#find) to locate the DOM node to be doubleClicked. It returns a promise that is resolved with the widget after the mouse has been doubleClicked on the target element. If you do not pass anything to doubleClick it will double click the root node of the widget.

```js
new this.Widget({
  root: ".double"
})
.doubleClick().then(function(widget) {
  //...
})
```

### sendKeys

`function sendKeys(<valueToSend>,...)`

`sendKeys` simulates a user typing. Derived from the [Webdriver sendKey method](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/actionsequence.js.src.html). It accepts a hash with an optional selector to scope the `find` operation. It requires a `keys` value in the hash which should be an array of the keys to be sent to the element. These keys may include special keys such as Driver.Key.ENTER. A list of those special keys can be found at [Selenium WebDriver docs](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/key.js.src.html).

```js
var Driver = require('selenium-webdriver');

new this.Widget({
  root: ".some-div"
}).sendKeys({
  selector: "input",
  keys: [
    "wow",
    Driver.Key.SPACE,
    "pioneer",
    Driver.Key.ENTER
  ]
}).then(function(){
  ...
})
```

### addClass

`function addClass({className: name, selector: <selector>})`

`addClass` will add the provided class name to the DOM node of the Widget. It takes a hash that can contain an optional selector. If you only pass a string to the method and not an object then it will use the string as the class name. It returns a promise that will resolve when the class has been added.

```js
var hidden = new Widget.extend({
  root: '.showing'
})
.addClass('hidden')
```

### removeClass

`function removeClass({className: name, selector: <selector>})`

`removeClass` will remove the provided class name from the DOM node of the Widget. It takes a hash that can contain an optional selector. If you only pass a string to the method and not an object then it will use the string as the class name. It returns a promise that will resolve when the class has been removed.

### toggleClass

`function toggleClass({className: name, selector: <selector>})`

`toggleClass` will toggle the provided class name on the DOM node of the Widget. It takes a hash that can contain an optional selector. If you only pass a string to the method and not an object then it will use the string as the class name. It returns a promise that will resolve when the class has been toggled.

### clear

`function clear({selector: <selector>})`

`clear` will call [clear](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/webdriver.js.src.html#l1967) on the element. Takes a hash that supports an optional selector to scope the `clear` operation. If only a string is passed to clear, and not an object then it will use it as a selector for the `find` operation.
Returns a promise that resolves with the widget once the element has been cleared.

```js
new this.Widget({
  root: "#container"
}).clear({
  selector: "input"
}).then(function(widget){
  ...
});
```

## Querying the DOM

## read

`function read({selector: <selector>, transformer: <function>})`

`read` allows you to get the text of a given DOM node. `read` takes a hash of options: `<selector>` can scope the read, and `<transformer>` performs a transformation on the value/text. If you only pass a string to the method and not an object then it will use the string as the selector scope for the read operation.
It returns a promise that resolves with the result of the read or rejection.

```js
var PuppyDetails = Widget.extend({
  root: '.puppy-details',
  getName: function(name) {
    return this.read(".dog-name");
  }
});
var HorseDetails = Widget.extend({
  root: '.horse-details',
  getName: function(name) {
    return this.read({
      selector: ".pony-name",
      transformer: function(text){
        return text.toLowerCase()
      }
    });
  }
});
```

## find

`function find({selector: <selector>, text: <text>})...`

`find` allows you to find a (single) matching element on the page and grab the resulting DOM node. If a node is not found it will reject the returned promise value, otherwise the promise is resolved with the DOM node.
`find` takes in an optional hash, in which a selector key can be specified, or text can be specified to find the first matching child of the widget. `find` does not function properly when both options are passed.
If only a string is passed to the method then it will use that string for selector for the find operation.

```js
var PuppyDetails = Widget.extend({
  root: '.puppy-details',
  getInfo: function(name) {
    return this.find(".dog-info");
  }
});
var ReptileDetails = Widget.extend({
  root: '.reptile-details',
  getInfo: function(name) {
    return this.find({text: "lizards"});
  }
});
```

## findAll

`function findAll(cssSelector)...`

`findAll` allows you to find a list of matching elements on a page. It returns a promise that resolves with a new [Widget List]() with the same root as the widget that invoked `findAll`. The item selector of this new Widget List will be the cssSelector argument.


```js
var PuppyDetails = Widget.extend({
  root: '.puppy-details',
  getInfoItems: function(name) {
    return this.findAll("li.dog-info");
  }
});
PuppyDetails.getInfoItems().then(function(list){
  list.invoke(...)
})
```

## isPresent

`function isPresent(<selector>)...`

`isPresent` is a utility method to check to see if a given widgets `root` or `root` scoped selector is present on the page.
If the element is found then the promise is successfully resolved with true, otherwise it is resolved with false.

## isVisible

`function isVisible({selector: <selector>})...`

`isVisible` is a utility method to check to see if a given selector is currently visible on the page.
If the element is visible then the promise is resolved with true, otherwise it is resolved with false.
If only a string is passed to the method then it will use that string as a selector.

## getAttribute

`function getAttribute({selector: <selector>, attribute: attributeName})...`

The `getAttribute` method allows you to search an element for a particular attribute. It takes a hash with an optional selector key. If you only pass a string to the method and not an object then it will use the string as the attribute name. It returns a promise that will resolve with the attribute value if found, otherwise it will resolve with null.
For further reference visit http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/webdriver.js.src.html#l1851

```html
<p><img class='nested' width='400px'>I am nested</span></p>
```
```js
var width = Widget.extend({
  root: 'p',
  getImgWidth: function(){
    return this.getAttribute({selector: ".nested", attribute:"width"})
  }
});
```

## getValue

`function getValue({selector: <selector>, transformer: <transformer>})...`

The `getValue` method lets you get the current value of a given input node. It returns a promise that resolves with the value of the node.

It takes an optional hash with a scoping selector, and/or a transformer. if only a string is passed to the method and not an object, it will use the string as the selector.

## getText

`function getText({selector: <selector>})...`

The `getText` method allows you to retrieve the text of a given element. It returns a promise that will resolve with the text if found, otherwise it will resolve with null.
`getText` takes an optional hash with a selector key.If only a string is passed to the method then it will use that string for selector for the find operation.

## getInnerHTML

`function getInnerHTML({selector: <selector>})`

The `getInnerHTML` method will retrieve the innerHTML of the selector element. It returns a promise. Proxied off of [innerHTML](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/webdriver.js.src.html#l2016).
If a string is passed to `getInnerHTML` it will parse it as a selector.

## getOuterHTML

`function getOuterHTML({selector: <selector>})`

The `getOuterHTML` method retrives the outerHTML of the selector element. It returns a promise. Proxied off of [outerHTML](http://selenium.googlecode.com/git/docs/api/javascript/source/lib/webdriver/webdriver.js.src.html#l1997).
If a string is passed to `getOuterHTML` it will parse it as a selector.

### hasClass

`function hasClass({className: name, selector: <selector>})`

`hasClass` will test the existence of the provided class name on the DOM node of the Widget. It takes a hash that can contain an optional selector. If you only pass a string to the method and not an object then it will use the string as the class name. It returns a promise that will resolve with `true` or `false`.
