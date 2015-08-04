
var
  schema $ require :../schema
  Immutable $ require :immutable
  shortid $ require :shortid

= exports.signup $ \ (db action)
  var
    newUser $ ... schema.user
      merge $ Immutable.fromJS action.data
      merge $ Immutable.fromJS $ {}
        :id (shortid.generate)
        :isOnline true
    name $  ... newUser (get :name) (trim)
    isNameEmpty $ is name.length 0
    oldUser $ ... db (getIn $ [] :tables :users) $ find $ \ (user)
      is (user.get :name) name
    isUserExisted $ ? oldUser
  case true
    isNameEmpty $ db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
      notifications.push $ schema.notification.merge $ Immutable.fromJS $ {}
        :id (shortid.generate)
        :text ":Name cannot be empty"
        :type :fail
    isUserExisted $ db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
      notifications.push $ schema.notification.merge $ Immutable.fromJS $ {}
        :id (shortid.generate)
        :text ":Name already token"
        :type :fail
    else $ ... db
      updateIn ([] :tables :users) $ \ (users)
        users.push newUser
      updateIn ([] :states action.stateId) $ \ (state)
        state.set :userId (newUser.get :id)

= exports.login $ \ (db action)
  var
    maybeUser $ Immutable.fromJS action.data
    user $ ... db
      getIn $ [] :tables :users
      find $ \ (user)
        is (user.get :name) (maybeUser.get :name)
  cond (? user)
    cond (is (user.get :password) (maybeUser.get :password))
      ... db
        updateIn ([] :tables :users) $ \ (users) $ users.map $ \ (user)
          cond (is user.name action.data.name)
            user.set :online true
            , user
        updateIn ([] :states action.stateId :userId) $ \ (prev)
          user.get :id
      db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
        notifications.push
          schema.notification.merge $ Immutable.fromJS $ {}
            :id (shortid.generate)
            :text ":wrong password"
            :type :fail
    db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
      notifications.push
        schema.notification.merge $ Immutable.fromJS $ {}
          :id (shortid.generate)
          :text ":no such user"
          :type :fail
