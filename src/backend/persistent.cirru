
var
  Pipeline $ require :../util/pipeline
  Immutable $ require :immutable
  fs $ require :fs
  path $ require :path
  colors $ require :colors

var _database $ Immutable.Map

var inPipeline $ Pipeline.create
= exports.in inPipeline

Pipeline.for inPipeline $ \ (data)
  = _database data

var dbpath $ path.join __dirname :data.json

setInterval
  \ ()
    -- console.log (colors.blue ":saving to disk") (_database.toJS)
    fs.writeFileSync dbpath
      JSON.stringify (_database.toJS) null 2
  , 4000
