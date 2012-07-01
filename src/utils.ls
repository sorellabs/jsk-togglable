/** utils.ls --- General utilities for finding targets
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


## Module jsk-togglable.utils ##########################################
module.exports = (engine) ->
  
  ### == Dependencies ==================================================
  {query-one} = (require \moros) engine


  
  ### == Core implementation ===========================================

  #### Function link-target
  # Returns the ID of a link's target.
  #
  # link-target :: Node -> Maybe String
  link-target = (x) ->
    id = ((x.get-attribute \href) || '') .match /#jsk::(.*)/
    id && id[1]


  #### Function target
  # Returns the element that is the target of an anchor element.
  #
  # target :: Node -> Node
  target = (x) ->
    id = (link-target x) || (x.get-attribute \data-jsk-target)
    query-one "##{id}"


  
  ### Exports ##########################################################
  { link-target, target }