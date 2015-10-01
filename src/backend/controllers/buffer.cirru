
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
    ? (db.getIn $ [] :tables :buffers stateId)
    db.updateIn ([] :tables :buffers stateId) $ \ (buffer)
      ... buffer
        set :text text
        set :topicId topicId
    ... db
      setIn ([] :tables :buffers stateId) $ ... schema.buffer
        set :id bufferId
        set :time time
        set :text text
        set :topicId topicId
        set :authorId userId

= exports.finish $ \ (db action)
  var
    stateId action.stateId
    userId $ db.getIn $ [] :states stateId :userId
    targetBuffer $ ... db
      getIn $ [] :tables :buffers stateId
  ... db
    deleteIn ([] :tables :buffers stateId)
    updateIn ([] :tables :messages) $ \ (messages)
      messages.push targetBuffer
