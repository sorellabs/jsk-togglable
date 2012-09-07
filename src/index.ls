/** index.ls --- Bootstrapping for togglable components.
 *
 * Version: -:package.version:-
 *
 * Copyright (c) 2012 Quildreen Motta
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation files
 * (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


## Module jsk-togglable ################################################
module.exports = (engine, events) ->

  
  ### == Dependencies ==================================================
  {query, add-class, listen} = (require \moros) engine, events
  {Eventful}                 = require \ekho
  {Togglable}                = require './core'
  {find-anchors, target}     = (require './utils') engine


  
  ### == Helpers =======================================================

  #### Function prevent-default
  # Prevents the default action of an event.
  #
  # prevent-default :: Event* -> IO ()
  ignore-event = (ev) -> ev.prevent-default!


  #### Function mark-as-processed
  # Marks a node as having been processed by the Togglable process.
  #
  # mark-as-processed :: xs:[Node*] -> xs
  mark-as-processed = add-class \jskp-togglable


  #### Function flatten
  # Flattens a list of lists of ``a``s into a list of ``a``s.
  #
  # flatten :: [[a]] -> [a]
  flatten = (xs) -> xs.reduce (+++), []


  #### Function make-togglables
  # Creates togglable instances for anchor nodes.
  #
  # make-togglables :: Eventful, [Node] -> [Togglable]
  make-togglables = (parent, xs) -> xs.map (x) ->
    listen \click (ignore-event >> -> y.trigger \click), x
    y = Togglable.make parent, [x, target x] +++ related x


  ### Exports ##########################################################

  #### Function jsk-togglable
  # Processes togglable anchors for the given selector constraint.
  #
  # jsk-togglable :: String -> [Togglable]
  (selector) ->
    root = Eventful.make!
    root.on \click -> this.toggle!
    flatten <| query selector .map (x) ->
      mark-as-processed x
      make-togglables root, find-anchors x
