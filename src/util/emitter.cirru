
= exports.createEmitter $ \ ()
  return $ {}
    :listeners $ []

= exports.triggerEmitter $ \ (emitter data)
  return $ emitter.listeners.map $ \ (fn)
    return $ fn data

= exports.watchEmitter $ \ (emitter fn)
  = emitter.listeners $ emitter.listeners.concat $ [] fn
  return emitter
