Pioneer.Iframe
===========

`Pioneer.Iframe` is a utility class that extends from the base `Pioneer.Widget` Class.

```js
  MyFrame = Widget.Iframe.extend({
    root: "iframe"
  });

  frame = new MyFrame();
  // Changing the context to interact with the contents of the iframe
  frame.focus();
  // Resetting the context to interact with the iframes parent.
  frame.unfocus();
```

## Table of contents
  * [Api](#api)
    * [Focus](#focus)
    * [Unfocus](#unfocus)

# API

## Focus

  `function focus()...`

  Switches context from the default window to the iframe. All subsequent methods will be performed in the iframe until `unfocus()` is called.
  Returns a promise that resolves to the widget instance on which it was called

## Unfocus

  `function unfocus()...`

  Switches context back to the default window (or the parent of the iframe).
  Returns a promise that resolves to the widget instance on which it was called
