
var
  Emitter $ require :../util/emitter
  Stream $ require :../util/stream

= exports.actionStream
  Stream.wrap $ Emitter.create

= exports.syncStream
  Stream.wrap $ Emitter.create

= exports.behaviorStream
  Stream.wrap $ Emitter.create
