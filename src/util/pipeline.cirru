
var Pipeline $ {}
= module.exports Pipeline

= Pipeline.create $ \ ()
  return $ {}
    :listeners $ []

= Pipeline.send $ \ (pipeline x)
  pipeline.listeners.forEach $ \ (handler)
    handler x

= Pipeline.for $ \ (pipeline handler)
  = pipeline.listeners $ pipeline.listeners.concat $ [] handler

= Pipeline.forward $ \ (x1 x2)
  Pipeline.for x1 $ \ (data)
    Pipeline.send x2 data

= Pipeline.map $ \ (pipeline handler)
  var x1 $ Pipeline.create
  Pipeline.for pipeline $ \ (data)
    Pipeline.send x1 $ handler data

= Pipeline.reduce $ \ (pipeline initial handler)
  var internalState initial
  var x1 $ Pipeline.create
  Pipeline.for pipeline $ \ (data)
    = internalState $ handler data internalState
    Pipeline.send x1 internalState
  return x1
