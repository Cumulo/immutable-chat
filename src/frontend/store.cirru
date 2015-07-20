
var
  Immutable $ require :immutable
  Pipeline $ require :../util/pipeline
  patch $ require :immutablepatch

var inPipeline $ Pipeline.create
= exports.in inPipeline

var _store $ Immutable.Map

var outPipeline $ Pipeline.reduce inPipeline _store $ \ (diff store)
  return $ patch store diff

= exports.out outPipeline