
var
  Pipeline $ require :../util/pipeline

var inPipeline $ Pipeline.create
var outPipeline $ Pipeline.create
= exports.in inPipeline
= exports.out outPipeline

var socket $ new WebSocket :ws://localhost:3000

Pipeline.for inPipeline $ \ (data)
  socket.send $ JSON.stringify data

= socket.onmessage $ \ (event)
  var data $ JSON.parse event.data
  Pipeline.send outPipeline data
