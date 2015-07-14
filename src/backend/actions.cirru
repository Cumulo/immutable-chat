
var
  Emitter $ require :../util/emitter
  Stream $ require :../util/stream

var action $ Emitter.create

= module.exports $ Stream.wrap action
