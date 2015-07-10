
var
  ({}~ createEmitter triggerEmitter watchEmitter) $ require :./emitter

= exports.createStream $ \ (emitter)
  return $ createEmitter

= exports.mapStream $ \ (stream fn)
  var newStream $ createStream
  watchEmitter stream $ \ (data)
    triggerEmitter newStream (fn data)

= exports.filterStream $ \ (stream fn)
  var newStream $ createStream
  watchEmitter stream $ \ (data)
    if (fn data) $ do
      triggerEmitter newStream data

= exports.mergeStream $ \ (streamA streamB)
  var newStream $ createStream
  watchEmitter streamA $ \ (data)
    triggerEmitter newStream (fn data)
  watchEmitter streamB $ \ (data)
    triggerEmitter newStream (fn data)
  return newStream

= exports.handleStream $ \ (stream fn)
  watchEmitter stream $ \ (data)
    fn data
  return stream
