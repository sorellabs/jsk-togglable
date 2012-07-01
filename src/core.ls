/** core.ls --- Basis for togglable elements
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



### == Dependencies ====================================================
{Eventful}                             = require \ekho
{has-class-p, add-class, remove-class} = require \moros/lib/presentation



### == Helpers =========================================================

#### Function any-active-p
# Checks if any of the items are active.
#
# any-active? :: [Node] -> Bool
any-active-p = (xs) -> has-class-p \active, xs .some Boolean

#### Function activate
# Activates all the given elements
#
# activate :: xs:[Node*] -> xs
activate = add-class \active

#### Function deactivate
# Deactivates all the given elements.
#
# deactivate :: xs:[Node*] -> xs
deactivate = remove-class \active



### == Core implementation =============================================

#### Object Togglable <| Eventful
#
# Manages a set of togglable elements.
#
# Togglable :: { "targets" -> [Node] }
#
Togglable = Eventful.derive {

  ##### Function init
  # Initialises a ``Togglable`` instance.
  #
  # init! :: @this:Object*, Eventful, [Node] -> this
  init: (parent, targets = []) ->
    Eventful.init.call this, parent
    @targets = targets
    @trigger \created
    this

  ##### Function show
  # Display all togglable targets.
  #
  # show! :: @this:Object* -> this
  show: ->
    activate @targets
    @trigger \shown
    this

  ##### Function hide
  # Hides all togglable targets.
  #
  # hide! :: @this:Object* -> this
  hide: ->
    deactivate @targets
    @trigger \hidden
    this

  ##### Function toggle
  # Toggles all togglable targets.
  #
  # toggle! :: @this:Object*, Bool? -> this
  toggle: (active) ->
    active = active ? any-active-p @targets

    switch
    | active    => @hide!
    | otherwise => @show!

}


### Exports ############################################################
module.exports = {
  Togglable
}