
var
  Immutable $ require :immutable
  Pipeline $ require :../util/pipeline
  schema $ require :./schema
  shortid $ require :shortid

var inPipeline $ Pipeline.create
= exports.in inPipeline

var _database $ Immutable.fromJS schema.databasew

var outPipeline $ Pipeline.reduce inPipeline _database $ \ (action db)
  console.log action
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
        set :privates $ thePrivates.set action.privateId schema.private
        set :tables $ theTables.set :users
          theUsers.map $ \ (aUser)
            return $ cond (is (aUser.get :id) action.privateId)
              aUser.set :isOnline true
              , aUser

    :private/disconnect
      var
        thePrivates $ db.get :privates
        theTables $ db.get :tables
        theUsers $ theUsers.get :users
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

= exports.out outPipeline
