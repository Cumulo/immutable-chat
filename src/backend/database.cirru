
var
  Immutable $ require :immutable
  dispatcher $ require :./dispatcher
  Stream $ require :../util/stream

var defaultData $ {}
  :tables $ {}
    :users $ []
    :messages $ []
    :topics $ []
    :tasks $ []
  :states $ {}

var _database $ Immutable.fromJS defaultData

var dataStream $ Stream.handle dispatcher _database $ \ (action database)

  console.log action

  return database

= module.exports dataStream
