Ruby CoffeeScript
=================

Ruby CoffeeScript is a thin wrapper around the `coffee` binary.

    CoffeeScript.compile File.open("script.coffee")

Dependencies
------------

This is **not** the CoffeeScript parser. This means you need to install `node` and `coffee`.

If your `coffee` binary is in a weird location, you can specify the path by hand.

    CoffeeScript.coffee_bin = "/usr/local/bin/coffee"
