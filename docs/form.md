Widget.Form
=================

## Table of contents
  * [Api](#api)
    * [submitSelector](#submitselector)
    * [submitForm](#submitform)
    * [submitWith](#submitwith)
    * [select](#select)

#API

## submitSelector

`submitSelector(<node>)` finds and returns the specified submit node. If node is not provided it will find the element of type 'submit'.

## submitForm

`submitForm` will find the submit selector and then call [click](docs/widget.md#click)

## submitWith

`submitWith` will call [fillAll](#docs/field.md#fillall) on each of keys value pairs passed into method, and then call the `click` method on the return of the `submitSelector` method.

```js
var waiver = new this.Widget.Form.extend({
  root: "#waiver",
})
waiver.submitWith({name: "Joe Doe", address: "55 Main St", reason: "N/A"});
```

## select

`function select({text: <text>, value: <value>, selector: <selector>})`

`select` can be used to select an option from a dropdown menu.
`select` takes an hash with an optional `<selector>` in which you can specifiy either `<text>` or `<value>` to select by. Specifiying both text and a value will result in an error. It returns a promise that will resolve with null.
