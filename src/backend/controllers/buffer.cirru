
var
  schema $ require :../schema
  Immutable $ require :immutable

= exports.create $ \ (db action)
  var
    stateId action.stateId
    bufferId action.id
    time action.time
    text action.data.text
    topicId $ db.getIn $ [] :states stateId :topicId
    userId $ db.getIn $ [] :states stateId :userId
  ... db
    updateIn ([] :tables :buffers) $ \ (buffers)
      buffers.push $ ... schema.buffer
        set :id bufferId
        set :time time
        set :text text
        set :topicId topicId
        set :authorId userId
    setIn ([] :states action.stateId :bufferId) bufferId

= exports.update $ \ (db action)
  var
    bufferId $ db.getIn $ [] :states action.stateId :bufferId
    text action.data.text
  db.updateIn ([] :tables :buffers) $ \ (buffers)
    buffers.map $ \ (aBuffer)
      cond (is (aBuffer.get :id) bufferId)
        ... aBuffer
          set :text text
        , aBuffer

= exports.finish $ \ (db action)
  var
    stateId action.stateId
    bufferId $ db.getIn $ [] :states stateId :bufferId
    targetBuffer $ ... db
      getIn $ [] :tables :buffers
      find $ \ (buffer)
        is (buffer.get :id) bufferId
  ... db
    updateIn ([] :tables :buffers) $ \ (buffers)
      buffers.filter $ \ (aBuffer)
        isnt (aBuffer.get :id) bufferId
    updateIn ([] :tables :messages) $ \ (messages)
      messages.push $ ... targetBuffer
        set :isTopic false
    setIn ([] :states stateId :bufferId) null
