
var
  schema $ require :../schema

= exports.connect $ \ (db action)
  var
    stateId action.state
    userId $ db.getIn $ [] :states stateId :userId
  ... db
    updateIn ([] :states action.stateId) $ \ (prev)
      schema.state.set :id action.stateId

= exports.disconnect $ \ (db action)
  var
    stateId action.stateId
    userId $ db.getIn $ [] :states stateId :userId
  ... db
    deleteIn $ [] :states stateId
    updateIn ([] :tables :users) $ \ (users)
      users.map $ \ (aUser)
        cond (is (aUser.get :id) userId)
          aUser.set :isOnline false
          , aUser
    deleteIn ([] :tables :buffers stateId)

= exports.focus $ \ (db action)
  db.updateIn ([] :states action.stateId :isFocused) $ \ (prev) true

= exports.blur $ \ (db action)
  db.updateIn ([] :states action.stateId :isFocused) $ \ (prev) false

= exports.check $ \ (db action)
  db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
    notifications.filter $ \ (notification)
      isnt (notification.get :id) action.data

= exports.topic $ \ (db action)
  db.setIn ([] :states action.stateId :topicId) action.data
