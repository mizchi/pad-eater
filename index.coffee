# For xbox controller profile
class PadEater
  constructor: (@fps = 60) ->
    @stream = []
    @maxKeyHistory = 50

  getState: ->
    @stream[0]

  _poll: ->
    pad = navigator.getGamepads().item()
    pressed = pad.buttons.map (b) -> b.pressed
    [a, b, x, y, l1, r1, l2, r2, select, start, l_push, r_push, up, down, left, right, siitake] = pressed
    [lx, ly, rx, ry] = pad.axes
    keystate =
      pressed: {a, b, x, y, l1, r1, l2, r2, select, start, l_push, r_push, up, down, left, right, siitake}
      axes: {lx, ly, rx, ry}
      timestamp: pad.timestamp
    @stream.unshift keystate
    if @stream.length > @maxKeyHistroy
      @stream.pop()

  waitUntilPadActive: (fn) ->
    # chrome's gamepadconnected event is unreliable
    do wait = =>
      setTimeout =>
        pads = navigator.getGamepads()
        pad = pads[0] or pad?.item()
        if pad
          fn()
        else
          wait()
      , 300

  start: ->
    @waitUntilPadActive =>
      do update = =>
        setTimeout =>
          @_poll()
          update()
        , 1000/@fps

module.exports = PadEater
# window.addEventListener 'load', =>
  # eater = new PadEater(60)
  # eater.start()
  # window.eater = eater
