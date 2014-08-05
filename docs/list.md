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
    * [ItemSelector](#itemselector)
    * [ItemClass](#itemclass)
    * [Items](#items)
    * [Filter](#filter)
    * [Map](#map)
    * [At](#at)
    * [clickAt](#clickat)
    * [readAt](#readat)
# API

## ItemSelector

The `CSS` selector that is used when finding a single `Widget` contained within the list. It defaults to `li` but can be overridden to any valid `CSS` selector.

## ItemClass

The `Widget` to be instantiated and used when interacting with each item in the list. `ItemClass` defaults to a generic `World.Widget` class.

## Items

`function items()...`

Returns a `Promise` that resolves to a list of `Widgets` present in the `DOM` at call time.

## Filter

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

## Map

`function map(<iterator>(itemInstance))...`

Returns a `Promise` that resolves to a list of items transformed according to the iterator method.

The `iterator` can return a flat value or a `Promise`.

Here is an example of mapping a list of items down to their text content.

```js
new ListItems().map(function(item) {
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

## At

`function at(0-based-index)...`

Returns a promise that resolves with a child `Widget` instance at a given index.

```js
new ListItems().at(2).then(function(item) {});
```

## FindWhere

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

`function clickAt(index, <selector>)`

`clickAt` is a combination of the [at](#at) method and the [click](docs/widget.md#click) method that allows clicking on a certain index of list. The optional `<selector>` parameter allows for scoping within index. It returns a promise that is resolved when the index has been clicked.

```html
<ul>
<li>zero</li>
<li>one</li>
<li>two</li>
<li>three</li>
</ul>
```
```js
new Widget.List()
.clickAt(3)         //results in <li>three</li> being clicked
```

## readAt

`function readAt(index, <selector>, <transformer>)`

`readAt` is a combination of the [at](#at) method and the [read](docs/widget.md#read) method and allows for scoping within an el at the given index. The optional `<selector>` parameter allows for scoping within index. There is also an optional transformer argument that mirrors the default [read transformer](docs/widget.md#read) implementation. Read at returns a promise that resolves with the value of read.


``js
new Widget.List().readAt(1, 'p', function(val){
  return $.trim(val);
})
