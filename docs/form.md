Widget.Form
=================

## Table of contents
  * [Api](#api)
    * [submitSelector](#submitselector)
    * [submitForm](#submitform)
    * [submitWith](#submitwith)
    * [select](#select)
    * [fillAll](#fillall)
    * [readAll](#readall)

## submitSelector

`submitSelector` finds and returns an element of type `submit`. It can be overridden to find select another element for the target of [submitForm](#submitform)

```js
var F = this.Widget.Form.extend({
  root: "#my-form",
  submitSelector: function(){
    return this.find("button.mySubmit")
  }
})
```

## submitForm

`submitForm` will find the submit selector and then call [click](widget.md#click)

## submitWith

`submitWith` will call [fillAll](#fillall) on each of keys value pairs passed into method, and then call the `click` method on the return of the `submitSelector` method.

```js
var F = this.Widget.Form.extend({
  root: "#waiver",
})

var waiver = new F;
waiver.submitWith({name: "Joe Doe", address: "55 Main St", reason: "N/A"});
```

## select

`function select({text: <text>, value: <value>})`

`select` takes a hash in which you can specifiy either `<text>` or `<value>` to select by. Specifiying both text and a value will result in an error. Alternately, you can also just pass a single string value and it will be the same as passing in the `<text>` hash option.  `select` returns a promise that will resolve with null.

```html
<div class="form2">
  <select>
    <option value="one">Option Number 1</option>
    <option value="two">Option Number 2</option>
    <option value="three">Option Number 3</option>
  </select>
</div>
```
```js
return new this.Widget.Form({
  root: "form2"
})
.select({
  selector: "select",
  value: "three"
})
//Resulting in the selection of the option with a value of "three".

// Two-forms of selecting by text
return new this.Widget.Form({
  root: "form2"
})
.select("Option Number 3")
// The above is the shortform of the following
return new this.Widget.Form({
  root: "form2"
})
.select({text: "Option Number 3"})

```

## fillAll

`fillAll` will call the [fill](widget.md#fill) method on each of the the keys value pairs passed into the method.

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

`readAll` will map all fields and then [getValue](widget.md#getvalue) its value. It returns an object with each field name as a key and the value of that field.

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
// Result: {field1: "firstValue", field2: "secondValue", field3: "thirdValue"}
```
