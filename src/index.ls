#* Module jsk-togglable
#
# Bootstrapping for togglable components.
#
#
# Copyright (c) 2012 Quildreen Motta
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


module.exports = (engine, events) ->

  
  ### -- Dependencies --------------------------------------------------
  {query, add-class, listen, map-concat, map} = (require 'doom') engine, events
  {Eventful}                                  = require 'ekho'
  {Togglable}                                 = require './core'
  {find-anchors, target}                      = (require './utils') engine


  
  ### -- Helpers -------------------------------------------------------

  #### λ prevent-default
  # Prevents the default action of an event.
  #
  # :: Event* -> IO ()
  ignore-event = (ev) -> ev.prevent-default!


  #### λ mark-as-processed
  # Marks a node as having been processed by the Togglable process.
  #
  # :: xs:[Node*] -> xs
  mark-as-processed = add-class \jskp-togglable


  #### λ flatten
  # Flattens a list of lists of `a`s into a list of `a`s.
  #
  # :: [[a]] -> [a]
  flatten = (xs) -> xs.reduce (++), []


  #### λ make-togglables
  # Creates togglable instances for anchor nodes.
  #
  # :: Eventful, [Node] -> [Togglable]
  make-togglables = (parent, xs) -> xs |> map (x) ->
    listen \click (ignore-event >> -> y.trigger \click), x
    y = Togglable.make parent, [x, target x] ++ related x


  ### -- Exports -------------------------------------------------------

  #### λ jsk-togglable
  # Processes togglable anchors for the given selector constraint.
  #
  # :: String -> [Togglable]
  (selector) ->
    root = Eventful.make!
    root.on \click -> this.toggle!
    (query selector) |> map-concat (x) ->
      mark-as-processed x
      make-togglables root, find-anchors x
