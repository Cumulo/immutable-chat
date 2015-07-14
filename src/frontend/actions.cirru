
var
  Stream $ require :../util/stream
  Emitter $ require :../util/emitter
  dispatcher $ require :./dispatcher
  hubs $ require :./hubs

= exports.dispatch $ \ (data)
  Emitter.trigger (Emitter.unwrap hubs.actionStream) data
