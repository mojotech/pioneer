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

`select` takes a hash with an optional `<selector>` in which you can specifiy either `<text>` or `<value>` to select by. Specifiying both text and a value will result in an error. It returns a promise that will resolve with null.

## fillAll

`fillAll` will call the [fill](docs/widget.md#fill) method on each of the the keys value pairs passed into the method.

```js
Widget.find({
  root: 'form'
}).then(function(widget) {
  widget.fillAll({
    field1: "myEmail@example.com"
  })
});
```

## readAll

`readAll` will map all fields and then [read](docs/widget.md#read) its value. It returns an array in the form of [[fieldName, value],[fieldName, value]].

```html
<form>
Field 1: <input type="text" name="field1" value="firstValue"><br>
Field 2: <input type="text" name="field2" value="secondValue"><br>
Field 3: <input type="text" name="field3" value="thirdValue"><br>
</form>
```
```js
Widget.find({
  root: 'form'
}).then(function(widget) {
  widget.readAll()
})
            // Result:[["field1", "firstValue"],["field2", "secondValue"],["field3", "thirdValue"]]
```
