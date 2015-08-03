
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
    theStates $ db.get :states
    theTables $ db.get :tables
    theState $ theStates.get action.stateId
    theNotis $ theState.get :notifications
    theUsers $ theTables.get :users
    theBuffers $ theTables.get :buffers
    theMessages $ theTables.get :messages
    stateId action.stateId
  case action.type
    :user/create
      db.set :tables $ theTables.set :users
        theUsers.push $ schema.user.merge
          Immutable.fromJS $ {}
            :id (shortid.generate)
            :name action.data.name
            :avatar action.data.avatar

    :user/update
      db.set :tables $ theTables.set :users
        theUsers.map $ \ (aUser)
          return $ aUser.merge
            Immutable.fromJS action.data

    :buffer/create
      db.set :tables $ theTables.set :buffers
        theBuffers.push $ schema.buffer.merge
          Immutable.fromJS action.data

    :buffer/update
      var
        now $ new Date
      db.set :tables $ theTables.set :buffers
        theBuffers.map $ \ (aBuffer)
          return $ cond (is (aBuffer.get :id) action.data.id)
            ... aBuffer
              merge $ Immutable.fromJS action.data
              set :time (now.toISOString)
            , aBuffer

    :buffer/finish
      var
        theBuffer $ theBuffers.find $ \ (aBuffer)
          return $ is (aBuffer.get :id) action.data
        now $ new Date
      db.set :tables $ ... theTables
        set :buffers $ theBuffers.filter $ \ (aBuffer)
          isnt (aBuffer.get :id) action.data
        set :messages $ theMessages.push
          ... schema.message
            merge aBuffer
            set :time (now.toISOString)

    :message/promote
      db.set :tables $ theTables.set :messages
        theMessages.map $ \ (aMessage)
          return $ cond (is (aMessage.get :id) action.data)
            aMessage.set :isTopic true
            , aMessage

    :state/connect
      ... db
        set :states $ theStates.set action.stateId
          schema.state.set :id action.stateId
        set :tables $ theTables.set :users
          theUsers.map $ \ (aUser)
            return $ cond (is (aUser.get :id) action.stateId)
              aUser.set :isOnline true
              , aUser

    :state/disconnect
      ... db
        set :states $ theStates.delete action.stateId
        set :tables $ theTables.set :users
          theUsers.map $ \ (aUser)
            return $ cond (is (aUser.get :id) action.stateId)
              aUser.set :isOnline false
              , aUser

    :state/focus
      db.updateIn ([] :states action.stateId :isFocused)
        \ (prev) true

    :state/blur
      db.updateIn ([] :states action.stateId :isFocused)
        \ (prev) false

    :user/login
      var
        theUser $ theUsers.find $ \ (user)
          is (user.get :name) action.data.name
      cond (? theUser)
        cond (is (theUser.get :password) action.data.password)
          ... db
            updateIn ([] :tables :users) $ \ (theUsers) $ theUsers.map $ \ (user)
              cond (is user.name action.data.name)
                user.set :online true
                , user
            updateIn
              [] :states action.stateId :userId
              theUser.get :id
          db.updateIn
            [] :states action.stateId :notifications
            \ (theNotis) $ theNotis.merge
              schema.notification.merge $ Immutable.fromJS $ {}
                :id (shortid.generate)
                :content ":wrong password"
                :type :error
        db.updateIn
          [] :states action.stateId :notifications
          \ (theNotis) $ theNotis.push
            schema.notification.merge $ Immutable.fromJS $ {}
              :id (shortid.generate)
              :content ":no such user"
              :type :error
    :user/signup db
    else db
