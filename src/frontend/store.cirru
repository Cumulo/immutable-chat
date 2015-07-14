
var
  Emitter $ require :../util/emitter
  Stream $ require :../util/stream
  Immutable $ require :immutable
  hubs $ require :./hubs


var _store $ Immutable.Map

var storeStream $ Stream.reduce hubs.syncStream _store $ \ (syncEvent store)

  console.log syncEvent

  return store

= module.exports storeStream
