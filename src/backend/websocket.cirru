
var
  ws $ require :ws
  Pipeline $ require :../util/pipeline
  differ $ require :./differ

var inPipeline $ Pipeline.create
var outPipeline $ Pipeline.create
= exports.in inPipeline
= exports.out outPipeline

var register $ {}

var connectionHandler $ \ (socket)
  var id :fake-id
  socket.on :message $ \ (action)
    = action.privateId id
    Pipeline.send outPipeline action
  = (. register id) socket
  socket.on :close $ \ ()
    = (. register id) null

= exports.setup $ \ (options)
  var wss $ new ws.Server $ {} (:port options.port)
  wss.on :connection connectionHandler
  console.log ":ws server listening at" options.port

Pipeline.for inPipeline $ \ (operations)
  operations.forEach $ \ (op)
    var socket $ . register op.sessionId
    socket.send $ JSON.stringify op
