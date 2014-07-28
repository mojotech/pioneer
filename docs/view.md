Pioneer.Widget.View
===========

`Widget.View` is a utility class intended to make working with [Marionette.js](https://github.com/marionettejs/backbone.marionette) easier. It extends from the `Widget` class so you have a very similar interface with a few new things.

An example of the a `Widget.View` is as follows:

```js
  MarionetteView = this.Widget.View.extend({
    regionPath: 'MyRegion',
    appPath: "AppName"
  });

  return new MarionetteView().ui("wow")
  .then(function(element){
    return element.getText().should.eventually.equal("amaze");
  });
```

* [Api](#api)
  * [Constructing](#constructing)
    * [regionPath](#regionpath)
    * [appPath](#apppath)
  * [UI](#ui)


# API

## Constucting

`Widget.View` takes two additional params to allow you to hook into your view implementaiton on the client.

### RegionPath

Region path is the location of the region within you application.
`regionPath` is required when making a new `Widget.View`. It supports deeply nested views using a dot deliminated syntax. `FooRegion.BarRegion.ZapRegion` which is expanded internally to be `FooRegion.currentView.BarRegion.currentView.ZapRegion`.

```js
MarionetteView = this.Widget.View.extend({
  regionPath: 'MyRegion.NestedRegion.AmazingRegion'
})
```

### AppPath

App Path is the location of how to get to your application that stores your regions. By default `appPath` is `window` which will lookup your regions on the global scope, however you can scope this lookup by the `appPath`.

```js
MarionetteView = this.Widget.View.extend({
  regionPath: 'MyRegion.NestedRegion.AmazingRegion',
  appPath: 'window.secret.MyApp'
})
```

## UI

The `.ui` method on `Widget.View` allows you to hook into any UI hash keys that you have defined on your `Marionette.View`. http://marionettejs.com/docs/marionette.itemview.html#organizing-ui-elements

It takes a string that will be used for the lookup, the resulting value is a `WebElement` instance.

Given the following `Marionette.ItemView`

```js
Backbone.Marionette.ItemView.extend({
  template: _.template("<borg>the borg</borg><assimilate>like to eat cheerios</assimilate>"),
  ui: {
    "assimilate": "assimilate",
    "borg": "borg"
  }
})
```

You can interact with it via the `Widget.View` through the following widget.

```js
return new this.Widget.View({
  regionPath: "myRegion"
})
.ui("borg")
.then(function(elm){
  return elm.getText().should.eventually.eql("the borg")
});
```
