Ruby CoffeeScript
=================

Ruby CoffeeScript is a bridge to the official CoffeeScript 1 compiler.

    CoffeeScript.compile File.read("script.coffee")


Installation
------------

    gem install coffee-script

*Note: This compiler library has replaced the original CoffeeScript
 compiler that was written in Ruby.*


Dependencies
------------

This library depends on the `coffee-script-source` gem. Up until version 1.12.2, the `coffee-script-source` gem's version number has been synced with each official CoffeeScript release. This way you could build against different versions of CoffeeScript 1 by requiring the correct version of the `coffee-script-source` gem.

You *can* use this library with other versions of CoffeeScript by setting the `COFFEESCRIPT_SOURCE_PATH` environment variable, but we recommend using WebPacker for CoffeeScript 2 and up.

    export COFFEESCRIPT_SOURCE_PATH=/path/to/coffee-script/extras/coffee-script.js

### JSON

The `json` library is also required but is not explicitly stated as a
gem dependency. If you're on Ruby 1.8 you'll need to install the
`json` or `json_pure` gem. On Ruby 1.9, `json` is included in the
standard library.

### ExecJS

The [ExecJS](https://github.com/sstephenson/execjs) library is used to automatically choose the best JavaScript engine for your platform. Check out its [README](https://github.com/sstephenson/execjs/blob/master/README.md) for a complete list of supported engines.
