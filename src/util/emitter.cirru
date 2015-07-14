
= exports.create $ \ ()
  return $ {}
    :type :emitter
    :listeners $ []

= exports.trigger $ \ (emitter data)
  emitter.listeners.map $ \ (fn)
    return $ fn data

= exports.watch $ \ (emitter fn)
  = emitter.listeners $ emitter.listeners.concat $ [] fn
  return emitter

= exports.unwrap $ \ (stream)
  return stream.emitter
