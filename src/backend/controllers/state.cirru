
var
  schema $ require :../schema

= exports.connect $ \ (db action)
  ... db
    updateIn ([] :states action.stateId) $ \ (prev)
      schema.state.set :id action.stateId
    updateIn ([] :tables :users) $ \ (users)
      users.map $ \ (aUser)
        cond (is (aUser.get :id) action.stateId)
          aUser.set :isOnline true
          , aUser

= exports.disconnect $ \ (db action)
  ... db
    deleteIn $ [] :states action.stateId
    updateIn ([] :tables :users) $ \ (users)
      users.map $ \ (aUser)
        cond (is (aUser.get :id) action.stateId)
          aUser.set :isOnline false
          , aUser

= exports.focus $ \ (db action)
  db.updateIn ([] :states action.stateId :isFocused) $ \ (prev) true

= exports.blur $ \ (db action)
  db.updateIn ([] :states action.stateId :isFocused) $ \ (prev) false

= exports.check $ \ (db action)
  db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
    notifications.filter $ \ (notification)
      isnt (notification.get :id) action.data
