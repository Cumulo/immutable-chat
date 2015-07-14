
= exports.create $ \ ()
  return $ {}
    :listeners $ []

= exports.trigger $ \ (emitter data)
  return $ emitter.listeners.map $ \ (fn)
    return $ fn data

= exports.watch $ \ (emitter fn)
  = emitter.listeners $ emitter.listeners.concat $ [] fn
  return emitter
