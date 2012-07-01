_ = require \slake-build-utils
fs = _.fs

global <<< require \prelude-ls
defer = process.next-tick

# == Configuration =====================================================
defaults = void
environment =
  package: require './package.json'

# == Tasks =============================================================
task \clean 'Removes all build artifacts.' ->
  defer _.display-errors
  _.header "› Removing all build artifacts..."
  each fs.remove, <[ lib build dist test/build ]>


task \build 'Builds JavaScript files out of LiveScript ones.' ->
  defer _.display-errors
  _.tasks.compile-ls \src \lib compile:defaults, environment:environment


task \package 'Packages Togglable in a nice .tar.gz package.' ->
  version = environment.package.version
  fs.initialise \dist
  fs.copy \build "dist/jsk-togglable-#version"
  _.tasks.pack \dist "jsk-togglable-#version" ["jsk-togglable-#version"] _.display-errors
