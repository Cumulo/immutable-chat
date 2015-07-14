
var
  Emitter $ require :./emitter

var Stream exports

= Stream.wrap $ \ (emitter)
  return $ {}
    :type :stream
    :emitter emitter

= Stream.map $ \ (stream fn)
  var newEmitter $ Emitter.create
  Emitter.watch (Emitter.unwrap stream) $ \ (data)
    Emitter.trigger newEmitter (fn data)
  return $ Stream.wrap newEmitter

= Stream.filter $ \ (stream fn)
  var newEmitter $ Emitter.create
  Emitter.watch (Emitter.unwrap stream) $ \ (data)
    if (fn data) $ do
      Emitter.trigger newEmitter data
  return $ Stream.wrap newEmitter

= Stream.merge $ \ (streamA streamB)
  var newEmitter $ Emitter.create
  Emitter.watch (Emitter.unwrap streamA) $ \ (data)
    Emitter.trigger newEmitter (fn data)
  Emitter.watch (Emitter.unwrap streamB) $ \ (data)
    Emitter.trigger newEmitter (fn data)
  return newEmitter

= Stream.reduce $ \ (stream initial method)
  var newEmitter $ Emitter.create
  var interalState initial
  Emitter.watch (Emitter.unwrap stream) $ \ (data)
    = interalState $ method data interalState
    Emitter.trigger newEmitter interalState
  return $ Stream.wrap newEmitter

= Stream.handle $ \ (stream fn)
  Emitter.watch (Emitter.unwrap stream) $ \ (data)
    fn data
  return stream
