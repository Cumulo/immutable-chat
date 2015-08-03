
var
  ws $ require :ws
  Pipeline $ require :cumulo-pipeline
  differ $ require :./differ
  shortid $ require :shortid

= exports.in $ new Pipeline
= exports.out $ new Pipeline

var register $ {}

var connectionHandler $ \ (socket)
  var id $ shortid.generate

  = (. register id) socket
  socket.on :close $ \ ()
    = (. register id) null
    exports.out.send $ {}
      :stateId id
      :type :state/disconnect

  socket.on :message $ \ (rawData)
    var action $ JSON.parse rawData
    = action.stateId id
    exports.out.send action

  exports.out.send $ {}
    :stateId id
    :type :state/connect

= exports.setup $ \ (options)
  var wss $ new ws.Server $ {} (:port options.port)
  wss.on :connection connectionHandler
  console.log ":ws server listening at" options.port

exports.in.for $ \ (op)
  var socket $ . register op.id
  if (? socket)
    do
      socket.send $ JSON.stringify op.diff
    do
      console.log ":missing socket" op
  return undefined

