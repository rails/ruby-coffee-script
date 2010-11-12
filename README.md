Ruby CoffeeScript
=================

Ruby CoffeeScript is a bridge to the official CoffeeScript compiler.

    CoffeeScript.compile File.read("script.coffee")


Installation
------------

    gem install coffee-script

*This compiler lib has replaced the original CoffeeScript compiler that was written in Ruby*


Dependencies
------------

The compiler depends on the `coffee-script-source` gem which is updated any time a new version of CoffeeScript is released. The gem's version number is sync'd up with the javascript release. This way you can build against different versions of CoffeeScript from this compiler.

You can also use this lib with unreleased versions of CoffeeScript:

    export COFFEESCRIPT_SOURCE_PATH=/path/to/coffee-script/extras/coffee-script.js

The json library is also required but is not explicity stated as a gem dependency. If you're on 1.8 you'll need to install the json or json_pure gem. Its already included in 1.9.


Engines
-------

The `coffee-script` lib will automatically choose the best JavaScript engine for your platform. The currently implemented engines are:

* **Node.js**. If the `node` binary is available in $PATH, it will be used to invoke the CoffeeScript compiler.

* **JavaScript Core**. If you're on OS X and don't have Node.js installed, the lib will fall back to the built-in JavaScript Core binary, `jsc`. This way you don't need any additional dependencies.

* **V8**. Shelling out to Node.js may be too slow for your production environment. In this case, install `therubyracer` gem, which provides a fast bridge between Ruby and V8.
