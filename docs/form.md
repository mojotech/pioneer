Dill.Widget.Form
=================

`Dill.Form`

## Table of contents
  * [Api](#api)
    * [submitSelector](#submitselector)
    * [submitForm](#submitform)
    * [submitWith](#submitwith)

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
