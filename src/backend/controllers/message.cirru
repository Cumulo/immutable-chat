
var
  Immutable $ require :immutable
  schema $ require :../../backend/schema

= exports.promote $ \ (db action)
  var
    time action.time
  db.updateIn ([] :messages) $ \ (messages)
    messages.map $ \ (aMessage)
      cond (is (aMessage.get :id) action.data)
        ... aMessage
          set :isTopic true
          set :lastTouch time
        , aMessage

= exports.topic $ \ (db action)
  var
    time action.time
    userId $ db.getIn $ [] :states action.stateId :userId
  var message $ ... schema.message
    merge $ Immutable.fromJS action.data
    set :id action.id
    set :topicId :root
    set :authorId userId
    set :isTopic true
    set :lastTouch time
  db.updateIn ([] :messages) $ \ (messages)
    messages.push message

= exports.create $ \ (db action)
  var userId $ db.getIn $ [] :states action.stateId :userId
  var topicId $ db.getIn $ [] :states action.stateId :topicId
  var message $ ... schema.message
    set :text action.data
    set :id action.id
    set :topicId topicId
    set :authorId userId
    set :isTopic false
  db.updateIn ([] :messages) $ \ (messages)
    messages.push message

= exports.clear $ \ (db action)
  ... db
    setIn ([] :messages) (Immutable.List)
    setIn ([] :visits) (Immutable.Map)
    setIn ([] :unreads) (Immutable.Map)
    setIn ([] :buffers) (Immutable.Map)
