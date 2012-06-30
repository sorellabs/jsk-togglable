Togglable
=========

**JumperSkirt's** Togglable provides the basic behaviours for elements that
  must alternatively be hidden or shown in a page.



### Example


### Requirements and supported platforms

This library makes use of a safely shim-able subset of ECMAScript 5
features. If you need to support older browsers, you'll have to include
the [es5-shim][] library.



### Installation

If you're using [Browserify][] — you really should! — to manage your
dependencies, just grab it from [NPM][]:

```bash
$ npm install -d jsk-togglable
```

Otherwise, [download the latest release][] and include both the
Browserify prelude and the Togglable library in your page:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Ur Awesome Stuff</title>
  </head>
  <body>
    {{ Lots of stuff might go here }}
    <script src="/path/to/browserify.js"></script>
    <script src="/path/to/jsk-togglable.js"></script>
  </body>
</html>
```

In any of the cases above, Togglable will be a `require`-able module in your
platform, so you can just use `require("jsk-togglable")` to instantiate it.



### Building

If you want to build stuff from the source, you'll need
[LiveScript][]. Once you've got that installed and `Slake` on your path,
just run:

```bash
$ git clone git:/github.com/killdream/jsk-togglable.git  # Download the project
$ cd jsk-togglable                                       # Move to the project folder
$ npm install -d                                         # Initialise the dependencies
$ slake build:all                                        # Runs the build tasks
```


### Tests

For building the test files, you can use `slake test`. For building them
continuously, use `slake test:continuous`.



### Licence

Togglable is licensed under the delicious and permissive [MIT][] licence. You
can happily copy, share, modify, sell or whatever — refer to the actual
licence text for `less` information:

```bash
$ less LICENCE.txt
```

[download the latest release]: https://github.com/downloads/killdream/jsk-togglable/jsk-togglable-0.1.0.tar.gz

[es5-shim]: https://github.com/kriskowal/es5-shim
[Browserify]: https://github.com/substack/node-browserify
[NPM]: http://npmjs.org/
[LiveScript]: https://gkz.github.com/LiveScript
[MIT]: https://raw.github.com/killdream/jsk-togglable/master/LICENCE.txt
