Ruby CoffeeScript
=================

Ruby CoffeeScript is a bridge to the official CoffeeScript compiler.

    CoffeeScript.compile File.read("script.coffee")


Installation
------------

    gem install coffee-script

*Note: This compiler library has replaced the original CoffeeScript
 compiler that was written in Ruby.*


Dependencies
------------

This library depends on the `coffee-script-source` gem which is
updated any time a new version of CoffeeScript is released. (The
`coffee-script-source` gem's version number is synced with each
official CoffeeScript release.) This way you can build against
different versions of CoffeeScript by requiring the correct version of
the `coffee-script-source` gem.

In addition, you can use this library with unreleased versions of
CoffeeScript by setting the `COFFEESCRIPT_SOURCE_PATH` environment
variable:

    export COFFEESCRIPT_SOURCE_PATH=/path/to/coffee-script/extras/coffee-script.js

The `json` library is also required but is not explicitly stated as a
gem dependency. If you're on Ruby 1.8 you'll need to install the
`json` or `json_pure` gem. On Ruby 1.9, `json` is included in the
standard library.


Engines
-------

The `coffee-script` library will automatically choose the best
JavaScript engine for your platform. The currently implemented engines
are:

* **Node.js**. If the `node` binary is available in `$PATH`, it will
    be used to invoke the CoffeeScript compiler.

* **JavaScript Core**. If you're on OS X and don't have Node.js
    installed, the library will fall back to the built-in JavaScript
    Core binary, `jsc`. This way you don't need to install any
    additional dependencies.

* **V8**. Shelling out to Node.js may be too slow for your production
    environment. In this case, install `therubyracer` gem, which
    provides a fast bridge between Ruby and V8.
