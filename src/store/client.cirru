
var
  Immutable $ require :immutable
  Emitter $ require :../util/emitter
  Etream $ require :../util/stream
  actions $ require :../actions

var ws $ new WebSocket :ws://localhost:3000

var socketEvents $ Emitter.create
var _data $ Immutable.Map

= ws.onmessage $ \ (rawData)
  var delta $ Immutable.fromJS $ JSON.parse rawData
  var newData $ patch _data delta
  Emitter.trigger socketEvents newData

Stream.handle actions.stream $ \ (action)
  ws.send $ JSON.stringify action

= exports.stream $ Stream.create socketEvents
= exports.