
var
  Pipeline $ require :../util/pipeline
  Immutable $ require :immutable
  diff $ require :immutablediff
  expand

var inPipeline $ Pipeline.create
var outPipeline $ Pipeline.create
= exports.in inPipeline
= exports.out outPipeline
= exports.setup $ \ (options)
  = expand options.expand

var _cache $ Immutable.fromJS $ {}

Pipeline.for inPipeline $ \ (db)
  var
    theTables $ db.get :tables
    thePrivates $ db.get :privates
  thePrivates.forEach $ \ (state)
    var
      theCache $ or
        _cache.get (state.get :id)
        Immutable.Map
    if
      or
        isnt (theCache.get :db) db
        isnt (theCache.get :state) state
      do
        var newTree $ expand theTables state
        Pipeline.send outPipeline $ object
          :id $ state.get :id
          :diff $ diff (theCache.get :tree) newTree
        = _cache $ _cache.set (state.get :id) $ ... theCache
          set :db db
          set :state state
          set :tree newTree
    return true
