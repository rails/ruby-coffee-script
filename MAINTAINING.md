# Maintaining

## Releasing a new version

This project follows [semver](http://semver.org/). So if you are making a bug
fix, only increment the patch level "1.0.x". If any new files are added, a
minor version "1.x.x" bump is in order.

### Make a release commit

To prepare the release commit:

1. Edit the [coffee-script.gemspec](https://github.com/rails/ruby-coffee-script/blob/master/coffee-script.gemspec)
`s.version` value.
3. Make a single commit with the description as "Ruby CoffeeScript 2.x.x".
4. Finally, tag the commit with `v2.x.x`.

``` sh
$ git pull
$ vim coffee-script.gemspec
$ git add coffee-script.gemspec
$ git commit -m "Ruby CoffeeScript 2.x.x"
$ git tag v2.x.x
$ git push
$ git push --tags
```

### Build source gem

When a CoffeeScript release is released to npm, it needs to be repackaged and
published to RubyGems.

``` sh
$ ./script/build-source-gem 1.x.x
$ gem push ./tmp/coffee-script-source-1.x.x.gem
```
