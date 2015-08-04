
var
  schema $ require :../schema
  Immutable $ require :immutable
  shortid $ require :shortid

= exports.create $ \ (db action)
  db.updateIn ([] :tables :buffers) $ \ (buffers)
    buffers.push $ schema.buffer.merge
      Immutable.fromJS action.data

= exports.update $ \ (db action)
  var
    now $ new Date
  db.updateIn ([] :tables :buffers) $ \ (buffers)
    buffers.map $ \ (aBuffer)
      cond (is (aBuffer.get :id) action.data.id)
        ... aBuffer
          merge $ Immutable.fromJS action.data
          set :time (now.toISOString)
        , aBuffer

= exports.finish $ \ (db action)
  var
    now $ new Date
  ... db
    updateIn ([] :tables :buffers) $ \ (buffers)
      buffers.filter $ \ (aBuffer)
        isnt (aBuffer.get :id) action.data
    updateIn ([] :tables :messages) $ \ (messages)
      messages.push $ ... schema.message
        merge aBuffer
        set :time (now.toISOString)
