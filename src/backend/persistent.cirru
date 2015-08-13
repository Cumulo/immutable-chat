
var
  Pipeline $ require :cumulo-pipeline
  Immutable $ require :immutable
  fs $ require :fs
  path $ require :path
  colors $ require :colors

var _database $ Immutable.Map

= exports.in $ new Pipeline

exports.in.for $ \ (data)
  = _database data

var dbpath $ path.join __dirname :data.json

setInterval
  \ ()
    -- console.log (colors.blue ":saving to disk") (_database.toJS)
    var rawContent $ JSON.stringify (_database.toJS) null 2
    if (> rawContent.length 4) $ do
      fs.writeFileSync dbpath rawContent
    return
  , 4000
