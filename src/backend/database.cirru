
var
  Immutable $ require :immutable
  Pipeline $ require :cumulo-pipeline
  schema $ require :./schema
  shortid $ require :shortid
  fs $ require :fs
  path $ require :path

= exports.in $ new Pipeline

var dbpath $ path.join __dirname :data.json
if (fs.existsSync dbpath)
  do
    var content $ JSON.parse $ fs.readFileSync dbpath :utf8
    = content.states $ {}
    var _database $ Immutable.fromJS content
  do
    var _database $ Immutable.fromJS schema.database

= exports.out $ exports.in.reduce _database $ \ (db action)
  var
    stateId action.stateId
  case action.type
    :user/signup
      db.updateIn ([] :tables :users) $ \ (users)
        users.push $ schema.user.merge
          Immutable.fromJS $ {}
            :id (shortid.generate)
            :name action.data.name
            :avatar action.data.avatar

    :user/update
      var
        newUser $ Immutable.fromJS action.data
      db.updateIn ([] :tables :users) $ \ (users)
        users.map $ \ (aUser)
          cond (is (aUser.get :id) (newUser.get :id))
            aUser.merge newUser
            , aUser

    :buffer/create
      db.updateIn ([] :tables :buffers) $ \ (buffers)
        buffers.push $ schema.buffer.merge
          Immutable.fromJS action.data

    :buffer/update
      var
        now $ new Date
      db.updateIn ([] :tables :buffers) $ \ (buffers)
        buffers.map $ \ (aBuffer)
          cond (is (aBuffer.get :id) action.data.id)
            ... aBuffer
              merge $ Immutable.fromJS action.data
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
        user $ ... db
          getIn $ [] :tables :users
          find $ \ (user)
            is (user.get :name) action.data.name
      cond (? user)
        cond (is (user.get :password) action.data.password)
          ... db
            updateIn ([] :tables :users) $ \ (users) $ users.map $ \ (user)
              cond (is user.name action.data.name)
                user.set :online true
                , user
            updateIn ([] :states stateId :userId) $ \ (prev)
              user.get :id
          db.updateIn ([] :states stateId :notifications) $ \ (notifications)
            notifications.push
              schema.notification.merge $ Immutable.fromJS $ {}
                :id (shortid.generate)
                :text ":wrong password"
                :type :fail
        db.updateIn ([] :states stateId :notifications) $ \ (notifications)
          notifications.push
            schema.notification.merge $ Immutable.fromJS $ {}
              :id (shortid.generate)
              :text ":no such user"
              :type :fail
    else db
