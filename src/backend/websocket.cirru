
var
  ws $ require :ws
  Emitter $ require :../util/emitter
  Stream $ require :../util/stream
  differ $ require :./differ

var actionEvents $ Emitter.create

var register $ {}

var wss $ new ws.Server $ {} (:post 3000)
wss.on :connection $ \ (socket)
  var id :fake-id
  socket.on :message $ \ (action)
    = action.id id
    Emitter.trigger actionEvents action
  = (. register id) socket
  socket.on :close $ \ ()
    = (. register id) null

Stream.handle differ $ \ (operations)
  operations.forEach $ \ (op)
    var socket $ . register op.sessionId
    socket.send $ JSON.stringify op

= exports.stream $ Stream.create actionEvents
