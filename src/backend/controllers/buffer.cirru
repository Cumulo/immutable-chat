
var
  schema $ require :../schema
  Immutable $ require :immutable

= exports.update $ \ (db action)
  var
    stateId action.stateId
    time action.time
    text action.data.text
    bufferId action.id
    topicId $ db.getIn $ [] :states stateId :topicId
    userId $ db.getIn $ [] :states stateId :userId
  cond
    ? (db.getIn $ [] :buffers stateId)
    db.updateIn ([] :buffers stateId) $ \ (buffer)
      ... buffer
        set :text text
        set :topicId topicId
    ... db
      setIn ([] :buffers stateId) $ ... schema.buffer
        set :id bufferId
        set :time time
        set :text text
        set :topicId topicId
        set :authorId userId

= exports.finish $ \ (db action)
  var
    stateId action.stateId
    time action.time
    userId $ db.getIn $ [] :states stateId :userId
    topicId $ db.getIn $ [] :states stateId :topicId
    targetBuffer $ ... db
      getIn $ [] :buffers stateId
  ... db
    deleteIn ([] :buffers stateId)
    updateIn ([] :messages) $ \ (messages)
      messages.push targetBuffer
    setIn ([] :visits userId topicId) time
    updateIn ([] :messages) $ \ (messages)
      messages.map $ \ (message)
        cond (is (message.get :id) topicId)
          message.set :lastTouch time
          , message
