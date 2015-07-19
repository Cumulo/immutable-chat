
var
  Pipeline $ require :../util/pipeline
  Immutable $ require :immutable
  diff $ require :immutablediff
  expand

var inPipeline $ Pipeline.create
var outPipeline $ Pipeline.create
= exports.in inPipeline
= exports.out outPipeline
= exports.configExpand $ \ (method)
  = expand method

var _cache $ Immutable.fromJS $ {}

Pipeline.for inPipeline $ \ (db)
  var
    theTables $ db.get :tables
    thePrivates $ db.get :privates
  privates.forEach $ \ (state)
    var
      theCache $ cache.get (state.get :id)
    if
      or
        isnt (theCache.get :db) db
        isnt (theCache.get :state) state
      do
        var newTree $ expand db state
        Pipeline.send outPipeline
          diff (theCache.get :tree) newTree
        = cache $ cache.set (state.get :id) $ ... theCache
          set :db db
          set :state state
          set :tree newTree
    return true
