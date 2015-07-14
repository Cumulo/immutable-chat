
var
  Immutable $ require :immutable
  Emitter $ require :../util/emitter
  Stream $ require :../util/stream
  hubs $ require :./hubs

var defaultData $ {}
  :username null
  :password null

var _session $ Immutable.fromJS defaultData

var sessionStream $ Stream.reduce hubs.behaviorStream _session $ \ (behavior session)

  console.log behavior

  return session

= module.exports sessionStream
