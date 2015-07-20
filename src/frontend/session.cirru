
var
  Immutable $ require :immutable
  Pipeline $ require :../util/pipeline

var inPipeline $ Pipeline.create
= exports.in inPipeline

var defaultData $ {}
  :username null
  :password null

var _session $ Immutable.fromJS defaultData

var outPipeline $ Pipeline.reduce inPipeline _session $ \ (action session)

  console.log behavior
  return session

= exports.out outPipeline
