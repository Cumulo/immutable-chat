
var
  Immutable $ require :immutable

= module.exports $ \ (db state)
  var
    userId $ state.get :userId
    topics $ ... db
      getIn $ [] :messages
      filter $ \ (aMessage) (aMessage.get :isTopic)
    groupedMessages $ ... db
      getIn $ [] :messages
      groupBy $ \ (message) (message.get :topicId)

  Immutable.Map $ {}
    :topics $ ... topics
      sortBy $ \ (message)
        - 0 (or (message.get :lastTouch) 0)
      map $ \ (message)
        var theUser $ ... db
          getIn $ [] :users
          find $ \ (aUser)
            is (aUser.get :id) (message.get :authorId)
        message.set :userRef theUser
    :members $ ... db
      getIn $ [] :users
      filter $ \ (aUser) (aUser.get :isOnline)
    :unreads $ ... groupedMessages
      map $ \ (messages topicId)
        var
          lastVisit $ db.getIn $ [] :visits userId topicId
          unreadMesages $ messages.filter $ \ (message)
            > (message.get :time) (or lastVisit 0)
        , unreadMesages.size
    :messages $ ... db
      getIn $ [] :messages
      filter $ \ (aMessage)
        or
          is (aMessage.get :id) (state.get :topicId)
          is (aMessage.get :topicId) (state.get :topicId)
      map $ \ (aMessage)
        var theUser $ ... db (getIn $ [] :users)
          find $ \ (aUser) $ is (aUser.get :id) (aMessage.get :authorId)
        aMessage.set :userRef theUser
    :buffers $ ... db
      getIn $ [] :buffers
      toList
      filter $ \ (buffer)
        is (buffer.get :topicId) (state.get :topicId)
      map $ \ (buffer)
        var theUser $ ... db (getIn $ [] :users)
          find $ \ (aUser) $ is (aUser.get :id) (buffer.get :authorId)
        buffer.set :userRef theUser
    :state state
    :user $ ... db
      getIn $ [] :users
      find $ \ (user)
        is (user.get :id) userId
    :visits $ or
      db.getIn $ [] :visits userId
      {}
