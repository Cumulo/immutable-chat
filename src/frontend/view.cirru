
var
  React $ require :react
  Pipeline $ require :../util/pipeline

var inPipeline $ Pipeline.create
var outPipeline $ Pipeline.create
= exports.out outPipeline
= exports.in inPipeline

= exports.action $ \ (data)
  Pipeline.send exports.out data

= exports.handle $ \ (data)
  Pipeline.send exports.out $ {}
    :type :session
    :data data
