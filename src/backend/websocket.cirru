
var
  ws $ require :ws
  Pipeline $ require :../util/pipeline
  differ $ require :./differ
  dispatcher $ require :./dispatcher

var inPipeline $ Pipeline.create
var outPipeline $ Pipeline.create
= exports.in inPipeline
= exports.out outPipeline

var register $ {}

var wss $ new ws.Server $ {} (:port 3000)
wss.on :connection $ \ (socket)
  var id :fake-id
  socket.on :message $ \ (action)
    = action.privateId id
    Pipeline.send outPipeline action
  = (. register id) socket
  socket.on :close $ \ ()
    = (. register id) null

Pipeline.for inPipeline $ \ (operations)
  operations.forEach $ \ (op)
    var socket $ . register op.sessionId
    socket.send $ JSON.stringify op
