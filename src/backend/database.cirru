
var
  Immutable $ require :immutable
  websocket $ require :./websocket
  Stream $ require :../util/stream

var defaultData $ {}
  :tables $ {}
    :users $ []
    :messages $ []
    :topics $ []
    :tasks $ []
  :states $ {}

var _database $ Immutable.fromJS defaultData

var dataStream $ Stream.handle websocket.stream _database $ \ (database action)

  console.log action

  return database

= module.exports dataStream
