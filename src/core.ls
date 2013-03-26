#* Module core
#
# Basis for togglable elements
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
#



### -- Dependencies ----------------------------------------------------
{Eventful}                           = require 'ekho'
{has-class, add-class, remove-class} = require 'doom/lib/presentation'



### -- Helpers ---------------------------------------------------------

#### λ any-active-p
# Checks if any of the items are active.
#
# :: [Node] -> Bool
any-active-p = (xs) -> has-class \active, xs .some Boolean

#### λ activate
# Activates all the given elements
#
# :: xs:[Node*] -> xs
activate = add-class \active

#### λ deactivate
# Deactivates all the given elements.
#
# :: xs:[Node*] -> xs
deactivate = remove-class \active



### -- Core implementation ---------------------------------------------

#### {} Togglable
#
# Manages a set of togglable elements.
#
# :: Eventful <| { "targets" -> [Node] }
#
Togglable = Eventful.derive {

  ##### λ init
  # Initialises a `Togglable` instance.
  #
  # :: @this:Object* => Eventful, [Node] -> this
  init: (parent, targets = []) ->
    Eventful.init.call this, parent
    @targets = targets
    @trigger \created
    this

  ##### λ show
  # Display all togglable targets.
  #
  # :: @this:Object* => () -> this
  show: ->
    activate @targets
    @trigger \shown
    this

  ##### λ hide
  # Hides all togglable targets.
  #
  # :: @this:Object* => () -> this
  hide: ->
    deactivate @targets
    @trigger \hidden
    this

  ##### λ toggle
  # Toggles all togglable targets.
  #
  # :: @this:Object* => Bool? -> this
  toggle: (active) ->
    active = active ? any-active-p @targets

    switch
    | active    => @hide!
    | otherwise => @show!

}


### -- Exports ---------------------------------------------------------
module.exports = {
  Togglable
}
