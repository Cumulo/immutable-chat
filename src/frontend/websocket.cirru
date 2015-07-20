
var
  Pipeline $ require :../util/pipeline

var inPipeline $ Pipeline.create
var outPipeline $ Pipeline.create
= exports.in inPipeline
= exports.out outPipeline

= exports.setup $ \ (options)

  Pipeline.for inPipeline $ \ (data)
    socket.send $ JSON.stringify data

  var socket $ new WebSocket $ + :ws://localhost: options.port
  = socket.onmessage $ \ (event)
    var data $ JSON.parse event.data
    Pipeline.send outPipeline data
