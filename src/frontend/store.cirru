
var
  Immutable $ require :immutable

var inPipeline $ Pipeline.create
= exports.in inPipeline

var _store $ Immutable.Map

var outPipeline $ Pipeline.reduce inPipeline _store $ \ (action store)
  return store

= exports.out outPipeline