
var
  Emitter $ require :./emitter

var Stream exports

= Stream.create $ \ (emitter)
  return $ emitter

= Stream.map $ \ (stream fn)
  var newStream $ Stream.create
  Emitter.watch stream $ \ (data)
    Emitter.trigger newStream (fn data)

= Stream.filterStream $ \ (stream fn)
  var newStream $ Stream.create
  Emitter.watch stream $ \ (data)
    if (fn data) $ do
      Emitter.trigger newStream data

= Stream.mergeStream $ \ (streamA streamB)
  var newStream $ Stream.create
  Emitter.watch streamA $ \ (data)
    Emitter.trigger newStream (fn data)
  Emitter.watch streamB $ \ (data)
    Emitter.trigger newStream (fn data)
  return newStream

= Stream.reduceStream $ \ (stream initial method)
  var newStream $ Stream.create
  var interalState initial
  Emitter.watch stream $ \ (data)
    = interalState $ method interalState data
    Emitter.trigger newStream interalState
  return newStream

= Stream.handleStream $ \ (stream fn)
  Emitter.watch stream $ \ (data)
    fn data
  return stream
