# PadEater

Xbox Controller State Poller for browser's gamecontroller api

Only for me.

```coffee
PadEater = require 'pad-eater'
eater = new PadEater 60 # polling fps
eater.start()

# get current status
eater.getState()
eater.stream # => array of key state
eater.maxKeyHistory = 100 # default 50
```
