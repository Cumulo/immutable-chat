
var
  Immutable $ require :immutable
  Pipeline $ require :cumulo-pipeline
  schema $ require :./schema
  shortid $ require :shortid
  fs $ require :fs
  path $ require :path

var
  fromJS Immutable.fromJS

= exports.in $ new Pipeline

var dbpath $ path.join __dirname :data.json
if (fs.existsSync dbpath)
  do
    var content $ JSON.parse $ fs.readFileSync dbpath :utf8
    = content.states $ {}
    var _database $ fromJS content
  do
    var _database $ fromJS schema.database

= exports.out $ exports.in.reduce _database $ \ (db action)
  var
    stateId action.stateId
  case action.type
    :user/signup
      var
        newUser $ ... schema.user
          merge $ fromJS action.data
          merge $ fromJS $ {}
            :id (shortid.generate)
            :isOnline true
        name $  ... newUser (get :name) (trim)
        isNameEmpty $ is name.length 0
        oldUser $ ... db (getIn $ [] :tables :users) $ find $ \ (user)
          is (user.get :name) name
        isUserExisted $ ? oldUser
      case true
        isNameEmpty $ db.updateIn ([] :states stateId :notifications) $ \ (notifications)
          notifications.push $ schema.notification.merge $ fromJS $ {}
            :id (shortid.generate)
            :text ":Name cannot be empty"
            :type :fail
        isUserExisted $ db.updateIn ([] :states stateId :notifications) $ \ (notifications)
          notifications.push $ schema.notification.merge $ fromJS $ {}
            :id (shortid.generate)
            :text ":Name already token"
            :type :fail
        else $ ... db
          updateIn ([] :tables :users) $ \ (users)
            users.push newUser
          updateIn ([] :states stateId) $ \ (state)
            state.set :userId (newUser.get :id)

    :user/update
      var
        newUser $ fromJS action.data
      db.updateIn ([] :tables :users) $ \ (users)
        users.map $ \ (aUser)
          cond (is (aUser.get :id) (newUser.get :id))
            aUser.merge newUser
            , aUser

    :buffer/create
      db.updateIn ([] :tables :buffers) $ \ (buffers)
        buffers.push $ schema.buffer.merge
          fromJS action.data

    :buffer/update
      var
        now $ new Date
      db.updateIn ([] :tables :buffers) $ \ (buffers)
        buffers.map $ \ (aBuffer)
          cond (is (aBuffer.get :id) action.data.id)
            ... aBuffer
              merge $ fromJS action.data
              set :time (now.toISOString)
            , aBuffer

    :buffer/finish
      var
        now $ new Date
      ... db
        updateIn ([] :tables :buffers) $ \ (buffers)
          buffers.filter $ \ (aBuffer)
            isnt (aBuffer.get :id) action.data
        updateIn ([] :tables :messages) $ \ (messages)
          messages.push $ ... schema.message
            merge aBuffer
            set :time (now.toISOString)

    :message/promote
      db.updateIn ([] :tables :messages) $ \ (messages)
        messages.map $ \ (aMessage)
          cond (is (aMessage.get :id) action.data)
            aMessage.set :isTopic true
            , aMessage

    :state/connect
      ... db
        updateIn ([] :states stateId) $ \ (prev)
          schema.state.set :id stateId
        updateIn ([] :tables :users) $ \ (users)
          users.map $ \ (aUser)
            cond (is (aUser.get :id) stateId)
              aUser.set :isOnline true
              , aUser

    :state/disconnect
      ... db
        deleteIn $ [] :states stateId
        updateIn ([] :tables :users) $ \ (users)
          users.map $ \ (aUser)
            cond (is (aUser.get :id) stateId)
              aUser.set :isOnline false
              , aUser

    :state/focus
      db.updateIn ([] :states stateId :isFocused) $ \ (prev) true

    :state/blur
      db.updateIn ([] :states stateId :isFocused) $ \ (prev) false

    :state/check
      db.updateIn ([] :states stateId :notifications) $ \ (notifications)
        notifications.filter $ \ (notification)
          isnt (notification.get :id) action.data

    :user/login
      var
        maybeUser $ fromJS action.data
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
            updateIn ([] :states stateId :userId) $ \ (prev)
              user.get :id
          db.updateIn ([] :states stateId :notifications) $ \ (notifications)
            notifications.push
              schema.notification.merge $ fromJS $ {}
                :id (shortid.generate)
                :text ":wrong password"
                :type :fail
        db.updateIn ([] :states stateId :notifications) $ \ (notifications)
          notifications.push
            schema.notification.merge $ fromJS $ {}
              :id (shortid.generate)
              :text ":no such user"
              :type :fail
    else db
