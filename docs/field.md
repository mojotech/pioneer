Widget.Field
=================

## Table of contents
  * [Api](#api)
    * [fillAll](#fillall)
    * [readAll](#readAll)

#API

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
