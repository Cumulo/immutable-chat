
var
  ws $ require :ws
  Pipeline $ require :../util/pipeline
  differ $ require :./differ
  shortid $ require :shortid

var inPipeline $ Pipeline.create
var outPipeline $ Pipeline.create
= exports.in inPipeline
= exports.out outPipeline

var register $ {}

var connectionHandler $ \ (socket)
  var id $ shortid.generate

  = (. register id) socket
  socket.on :close $ \ ()
    = (. register id) null
    Pipeline.send outPipeline $ {}
      :privateId id
      :type :private/disconnect

  socket.on :message $ \ (action)
    = action.privateId id
    Pipeline.send outPipeline action
  Pipeline.send outPipeline $ {}
    :privateId id
    :type :private/connect

= exports.setup $ \ (options)
  var wss $ new ws.Server $ {} (:port options.port)
  wss.on :connection connectionHandler
  console.log ":ws server listening at" options.port

Pipeline.for inPipeline $ \ (op)
  var socket $ . register op.id
  if (? socket)
    do
      socket.send $ JSON.stringify op.diff
    do
      console.log ":missing socket" op

