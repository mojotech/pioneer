module.exports = ->
  global.argv   = require('minimist')(process.argv)
  global.Driver = require 'selenium-webdriver'

  global._      = require 'lodash'
  global.$      = Driver.promise

  # *********************************************************************************
  # Extend Object with class helpers (used in the context of a class definition):
  # *********************************************************************************
  #
  #   includes - mixin classes (extends the class itself and the prototype)
  #
  #     class A
  #       @onTheClass: -> "hello world, I'm on a class"
  #       onAnInstance: -> "hello world, I'm on an instance"
  #
  #     class B
  #       @includes A
  #
  #     B.onTheClass()
  #     #  => "hello world, I'm on a class"
  #     (new B()).onAnInstance()
  #     #  => "hello world, I'm on an instance"
  #
  #     Note: unlike underscore's "extend" or coffeescript's class extension,
  #       include will successfully copy true getters and setters.
  #
  # ****************************************************************************
  #
  #   getter - define a getter function (evaluated whenever a property is accessed)
  #
  #     class A
  #       @getter 'hello', -> 'world!'
  #
  #     (new A).hello # => 'world!'
  #
  # *********************************************************************************
  #
  #   setter - define a setter function (evaluated whenever a property is assigned)
  #
  #     class A
  #       @getter 'hello', -> @_hello
  #       @setter 'hello', (value) -> @_hello = 'hello'
  #
  #     a = new A
  #     a.hello = 'friend!' #
  #     a.hello             # => 'friend!'
  #     a._hello            # => 'friend!'
  #
  # *********************************************************************************

  # return the descriptor for an object's property, regardless of
  # how far back in the prototype chain it was defined
  origDescriptor = (source, prop) ->
    return nil unless source
    Object.getOwnPropertyDescriptor(source, prop) ||
      origDescriptor(Object.getPrototypeOf(source), prop)

  Object.defineProperties Object::,

    # like _.extend but handles true getters and setters:
    copyProperties:
      value: (source) ->
        for prop of source
          Object.defineProperty @, prop, origDescriptor(source, prop)
        @

    includes:
      value: (mixin) ->
        @copyProperties(@, mixin)
        @copyProperties(@::, mixin::)
        @
    getter:
      value: (object, property, getter) ->
        unless getter
          [object, property, getter] = [@::, object, property]
        Object.defineProperty object, property,
          configurable: true, enumerable: true, get: getter
    setter:
      value: (object, property, setter) ->
        unless setter
          [object, property, getter] = [@::, object, property]
        Object.defineProperty object, property,
          configurable: true, enumerable: true, set: getter
    accessor:
      value: (object, property) ->
        unless property
          [object, property] = [@::, object]
        Object.defineProperty object, property,
          configurable: true,
          enumerable: true,
          get: ->
            @["_#{property}"]
          set: (v) ->
            @["_#{property}"] = v

  # *********************************************************************************
  #  Load assertion library (with promise extensions)
  # *********************************************************************************

  chai = require('chai')

  chai.use(require 'chai-as-promised')
  chai.should()

  # ********************************************************************************#
  #  In a show of defensive programming boarding on xenophobic, selenium-webdriver
  #   objects don't have Object.prototype in their prototype chain, so chai.should()
  #   doesn't work (since it adds a getter to Object.prototype). To work around this,
  #   we extend selenium-webdriver's Promise class's prototype directly.
  # *********************************************************************************

  Object.defineProperty(
    $.Promise::, 'should', get: Object::__lookupGetter__('should'))

  # ********************************************************************************#
  #  Circle CI doesn't seem to like ephemeral ports, and selenium-webdriver doesn't
  #   seem to have an easy way to modify the chromedriver port, so we monkey-patch
  #   it here.
  # ********************************************************************************#

  if process.env.CHROMEDRIVER_PORT
    require('../node_modules/selenium-webdriver/chrome').ServiceBuilder::port_ = process.env.CHROMEDRIVER_PORT
