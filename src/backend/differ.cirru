
var
  Emitter $ require :../util/emitter
  Stream $ require :../util/stream
  database $ require :./database

var _cache $ Immutable.fromJS $ {}

var diffStream $ Stream.reduce database _cache $ \ (cache snapshot)
  return $ []

= module.exports diffStream
