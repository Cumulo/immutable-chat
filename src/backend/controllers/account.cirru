
var
  schema $ require :../schema
  Immutable $ require :immutable

= exports.signup $ \ (db action)
  var
    newUser $ ... schema.user
      merge $ Immutable.fromJS action.data
      merge $ Immutable.fromJS $ {}
        :id action.id
        :isOnline true
    name $  ... newUser (get :name) (trim)
    isNameEmpty $ is name.length 0
    oldUser $ ... db (getIn $ [] :users) $ find $ \ (user)
      is (user.get :name) name
    isUserExisted $ ? oldUser
  case true
    isNameEmpty $ db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
      notifications.push $ schema.notification.merge $ Immutable.fromJS $ {}
        :id action.id
        :text ":Name cannot be empty"
        :type :fail
    isUserExisted $ db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
      notifications.push $ schema.notification.merge $ Immutable.fromJS $ {}
        :id action.id
        :text ":Name already token"
        :type :fail
    else $ ... db
      updateIn ([] :users) $ \ (users)
        users.push newUser
      updateIn ([] :states action.stateId) $ \ (state)
        state.set :userId (newUser.get :id)

= exports.login $ \ (db action)
  var
    maybeUser $ Immutable.fromJS action.data
    user $ ... db
      getIn $ [] :users
      find $ \ (user)
        is (user.get :name) (maybeUser.get :name)
  var noUser $ not $ ? user
  var isPasswordMatch false
  if (not noUser) $ do
    = isPasswordMatch $ is (user.get :password) (maybeUser.get :password)

  case true
    noUser $ db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
      notifications.push
        schema.notification.merge $ Immutable.fromJS $ {}
          :id action.id
          :text ":no such user"
          :type :fail

    isPasswordMatch $ ... db
      updateIn ([] :users) $ \ (users) $ users.map $ \ (user)
        cond (is (user.get :name) (maybeUser.get :name))
          user.set :isOnline true
          , user
      updateIn ([] :states action.stateId :userId) $ \ (prev)
        user.get :id
      updateIn ([] :states action.stateId :notifications) $ \ (notifications)
        notifications.push
          schema.notification.merge $ Immutable.fromJS $ {}
            :id action.id
            :text $ + ":Welcome, " (user.get :name)

    else $ db.updateIn ([] :states action.stateId :notifications) $ \ (notifications)
      notifications.push
        schema.notification.merge $ Immutable.fromJS $ {}
          :id action.id
          :text ":wrong password"
          :type :fail

= exports.logout $ \ (db action)
  var
    stateId action.stateId
  ... db
    setIn ([] :states stateId :userId) null
