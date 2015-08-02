
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
    = content.privates $ {}
    var _database $ Immutable.fromJS content
  do
    var _database $ Immutable.fromJS schema.database

var outPipeline $ exports.in.reduce _database $ \ (db action)
  switch action.type
    :user/create
      var
        theTables $ db.get :tables
        theUsers $ theTables.get :users
      return $ db.set :tables $ theTables.set :users
        theUsers.push $ schema.user.merge
          Immutable.fromJS $ {}
            :id (shortid.generate)
            :name action.data.name
            :avatar action.data.avatar

    :user/update
      var
        theTables $ db.get :tables
        theUsers $ theTables.get :users
      return $ db.set :tables $ theTables.set :users
        theUsers.map $ \ (aUser)
          return $ aUser.merge
            Immutable.fromJS action.data

    :buffer/create
      var
        theTables $ db.get :tables
        theBuffers $ theTables.get :buffers
      return $ db.set :tables $ theTables.set :buffers
        theBuffers.push $ schema.buffer.merge
          Immutable.fromJS action.data

    :buffer/update
      var
        theTables $ db.get :tables
        theBuffers $ theTables.get :buffers
        now $ new Date
      return $ db.set :tables $ theTables.set :buffers
        theBuffers.map $ \ (aBuffer)
          return $ cond (is (aBuffer.get :id) action.data.id)
            ... aBuffer
              merge $ Immutable.fromJS action.data
              set :time (now.toISOString)
            , aBuffer

    :buffer/finish
      var
        theTables $ db.get :tables
        theBuffers $ theTables.get :buffers
        theBuffer $ theBuffers.find $ \ (aBuffer)
          return $ is (aBuffer.get :id) action.data
        theMessages $ theTables.get :messages
        now $ new Date
      return $ db.set :tables $ ... theTables
        set :buffers $ theBuffers.filter $ \ (aBuffer)
          isnt (aBuffer.get :id) action.data
        set :messages $ theMessages.push
          ... schema.message
            merge aBuffer
            set :time (now.toISOString)

    :message/promote
      var
        theTables $ db.get :tables
        theMessages $ theTables.get :messages
      return $ db.set :tables $ theTables.set :messages
        theMessages.map $ \ (aMessage)
          return $ cond (is (aMessage.get :id) action.data)
            aMessage.set :isTopic true
            , aMessage

    :private/connect
      var
        thePrivates $ db.get :privates
        theTables $ db.get :tables
        theUsers $ theTables.get :users
      return $ ... db
        set :privates $ thePrivates.set action.privateId
          schema.private.set :id action.privateId
        set :tables $ theTables.set :users
          theUsers.map $ \ (aUser)
            return $ cond (is (aUser.get :id) action.privateId)
              aUser.set :isOnline true
              , aUser

    :private/disconnect
      var
        thePrivates $ db.get :privates
        theTables $ db.get :tables
        theUsers $ theTables.get :users
      return $ ... db
        set :privates $ thePrivates.delete action.privateId
        set :tables $ theTables.set :users
          theUsers.map $ \ (aUser)
            return $ cond (is (aUser.get :id) action.privateId)
              aUser.set :isOnline false
              , aUser

    :private/focus
      var
        thePrivates $ db.get :privates
        theState $ thePrivates.get action.privateId
      return $ db.set :privates $ thePrivates.set action.privateId
        theState.set :isFocused true

    :private/blur
      var
        thePrivates $ db.get :privates
        theState $ thePrivates.get action.privateId
      return $ db.set :privates $ thePrivates.set action.privateId
        theState.set :isFocused false
  return undefined

= exports.out outPipeline
