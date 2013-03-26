#* Module utils
#
# General utilities for finding targets
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


module.exports = (engine) ->
  
  ### -- Dependencies --------------------------------------------------
  {query, head, attribute1} = (require 'doom') engine


  
  ### -- Core implementation -------------------------------------------

  #### λ find-anchors
  # Selects nodes that can be used as toggling anchors for a context
  # node `x`.
  #
  # :: Node -> [Node]
  find-anchors = (x) ->
    query 'a.jsk-toggle[href*="#"], .toggle[data-jsk-target]' x


  #### λ link-target
  # Returns the ID of a link's target.
  #
  # :: Node -> Maybe String
  link-target = (x) ->
    id = ((attribute1 \href x) or '') .match /#(.*)/
    id && id[1]


  #### λ target
  # Returns the element that is the target of an anchor element.
  #
  # :: Node -> Node
  target = (x) ->
    id = (link-target x) || (attribute1 \data-jsk-target x)
    head (query "##{id}")


  #### λ related
  # Returns elements that are related to the anchor, but not direct targets.
  #
  # :: Node -> [Node]
  related = (x) ->
    | x.has-attribute \data-jsk-related => query (attribute1 \data-jsk-related x)
    | otherwise                         => []


  
  ### -- Exports -------------------------------------------------------
  { link-target, target, find-anchors }
