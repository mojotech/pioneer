Widget.List
===========

`Widget.List` is a utility to make operating on a collection of similar items intuitive. `Widget.List` allows you to specify collection specific methods, as well as the base `Widget` class to use for each `Widget` in the list.

Take for instance the following markup:

```html
<ul>
  <li> one </li>
  <li> sunny </li>
  <li> day </li>
</ul>
```

This list of words can abstracted and interacted with via a `List` with ease. Here is a simple example of asserting the length of the list.

```js
  ListItems = Widget.List.extend({
    root: "ul",
    itemSelector: "li"
  })

  list = new ListItems;

  list.items().should.eventually.have.length(3);
```

## Table of contents
  * [Api](#api)
    * [itemSelector](#itemselector)
    * [itemClass](#itemclass)
    * [getItemClass](#getItemClass)
    * [items](#items)
    * [length](#length)
    * [filter](#filter)
    * [map](#map)
    * [each](#each)
    * [invoke](#invoke)
    * [at](#at)
    * [clickAt](#clickat)
    * [readAt](#readat)

# API

## itemSelector

The `CSS` selector that is used when finding a single `Widget` contained within the list. It defaults to `li` but can be overridden to any valid `CSS` selector.

## itemClass

The `Widget` to be instantiated and used when interacting with each item in the list. `itemClass` defaults to a generic `World.Widget` class.

## getItemClass

The value returned by this method is the ItemClass that will be instantiated and used when interacting with each item in the list. This method gives you the ability to return a Customized ItemClass for each el. By default `itemClass` is returned.

```js
var MyListWidget = Widget.List.extend({
  getItemClass: function () {
    return this.Driver.promise.fulfilled(this.itemClass);
  }
});
```

## items

`function items()...`

Returns a `Promise` that resolves to a list of `Widgets` present in the `DOM` at call time.

## length

`function length()...`

Returns a `Promise` that resolves to the length of the list.

```js
new ListItems().length().should.eventually.eql(5)
```

## filter

`function filter(<predicateMethod>(itemInstance))...`

Returns a `Promise` that resolves to a reduced list of `items` according to the filter method.

The `predicateMethod` can either return a flat value or a `Promise` that resolves to a truthy or falsy value.

Here is an example of filtering the list of items down to those ending in "y".

```js
new ListItems().filter(function(item) {
  return item.find().then(function(elm) {
    return elm.getText().then(function(text) {
      return text.match(/y$/)
    });
  }
  })
});
```

## map

```js
function map(function iterator(widgetInstance, index) {
  //...
})
```

Returns a `Promise` that resolves to a list of items transformed according to the iterator method.

The `iterator` can return a flat value or a `Promise`.

Here is an example of mapping a list of items down to their text content.

```js
new ListItems().map(function(item, index) {
  // First we must find the `item`
  // and then call `getText` on the raw
  // `webElement` to get their contents.
  return item.find()
  .then(function(elm) {
    return elm.getText();
  })
})
.then(function(text) {
  return text.should.eql(["one", "sunny", "day"]);
})
```

## each

```js
function each(function iterator(widgetInstance, index) {
//...
}
```

Returns a promise that resolves with the list items after each item in the list has been iterated over. The iterator method receives two arguments, the widget instance and the index of the item being iterated over.

```js
new ListItems().each(function(item, index) {
  return item.click('.close');
});
```

## invoke

`function invoke({method: (methodName or method), arguments:<[arguments]>})...`

Returns a promise that resolves when the specified method has been invoked on all children.
If you only pass a string (or method) to `invoke`, and not an object, then it will use the string (or method) as the method to apply on each child.

```js
new ListItems().invoke('click').then(function() {
//....
});
```

```js
new ListItems().invoke(this.Widget.prototype.click).then(function() {
//....
});
```

```js
new ListItems().invoke({
  method: "click",
  arguments: [{
    selector: "p"
  }]
}).then(function(){
  //...
})
```

## at

`function at(0-based-index)...`

Returns a promise that resolves with a child `Widget` instance at a given index.

```js
new ListItems().at(2).then(function(item) {});
```

## findWhere

`function findWhere(<predicateMethod>(itemInstance))...`

Returns a `Promise` that resolves to a raw `WebElement` which represents the first element in the collection's items array which passes the filter method.

The `predicateMethod` can either return a flat value or a `Promise` that resolves to a truthy or falsy value.

Here is an example of finding the first item in a list of items that ends in "y".

```js
new ListItems().findWhere(function(item) {
  return item.find().then(function(elm) {
    return elm.getText().then(function(text) {
      return text.match(/y$/);
    });
  })
});
```
## clickAt

`function clickAt({index: index, selector:<selector>})`

`clickAt` is a combination of the [at](#at) method and the [click](widget.md#click) method that allows clicking on a certain index of list.
`clickAt` takes a hash, with an optional `<selector>` parameter which allows for scoping within index. If only a number is passed and not an options hash it will default to using that as the at index lookup
It returns a promise that is resolved when the child at the index has been clicked.

```html
<ul>
<li>zero</li>
<li>one</li>
<li>two</li>
<li>three</li>
</ul>
```
```js
new this.Widget.List()
.clickAt(3)         //results in <li>three</li> being clicked
```

## readAt

`function readAt({index: index, selector: <selector>, transformer: <transformer>)`

`readAt` is a combination of the [at](#at) method and the [read](widget.md#read) method and allows for scoping within an el at the given index. The optional `<selector>` parameter allows for scoping within index. There is also an optional transformer argument that mirrors the default [read transformer](widget.md#read) implementation. Read at returns a promise that resolves with the value of read.
If only a number is passed and not an options hash it will default to using that as the at index lookup


``js
new this.Widget.List().readAt(1, 'p', function(val){
  return $.trim(val);
})
