
var
  Immutable $ require :immutable

= exports.update $ \ (db action)
  var
    newUser $ Immutable.fromJS action.data
  db.updateIn ([] :tables :users) $ \ (users)
    users.map $ \ (aUser)
      cond (is (aUser.get :id) (newUser.get :id))
        aUser.merge newUser
        , aUser
