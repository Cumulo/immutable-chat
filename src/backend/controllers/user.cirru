
var
  Immutable $ require :immutable

= exports.update $ \ (db action)
  var
    newUser $ Immutable.fromJS action.data
  db.updateIn ([] :users) $ \ (users)
    users.map $ \ (aUser)
      cond (is (aUser.get :id) (newUser.get :id))
        aUser.merge newUser
        , aUser

= exports.name $ \ (db action)
  var userId $ ... db
    getIn $ [] :states action.stateId :userId
  db.updateIn ([] :users) $ \ (users)
    users.map $ \ (user)
      cond (is (user.get :id) userId)
        user.set :name action.data
        , user

= exports.avatar $ \ (db action)
  var userId $ ... db
    getIn $ [] :states action.stateId :userId
  db.updateIn ([] :users) $ \ (users)
    users.map $ \ (user)
      cond (is (user.get :id) userId)
        user.set :avatar action.data
        , user
