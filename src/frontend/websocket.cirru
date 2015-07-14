
var
  Emitter $ require :../util/emitter
  Stream $ require :../util/stream
  hubs $ require :./hubs

var socket $ new WebSocket :ws://localhost:3000

Stream.handle hubs.actionStream $ \ (data)
  socket.send $ JSON.stringify data

= socket.onmessage $ \ (event)
  var data $ JSON.parse event.data
  Emitter.trigger (Emitter.unwrap hubs.syncStream) data
