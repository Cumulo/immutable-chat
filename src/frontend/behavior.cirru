
var
  Emitter $ require :../util/emitter
  Stream $ require :../util/stream
  hubs $ require :./hubs

= exports.dispatch $ \ (data)
  Emitter.trigger (Emitter.unwrap hubs.behaviorStrem) data
