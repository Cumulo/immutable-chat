
var
  Immutable $ requre :immutable

= module.exports $ \ (tables state)
  var
    theTopics $ ... tables
      get :messages
      filter $ \ (aMessage)
        return $ aMessage.get :isTopic
    theOnline $ ... tables
      get :users
      filter $ \ (aUser)
        return $ aUser.get :isOnline
    theMessages $ cond (state.get :topicId)
      ... tables
        get :messages
        filter $ \ (aMessage)
          return $ is (aMessage.get id) (state.get :topicId)
      Immutable.List
  return $ Immutable.Map
    :topics theTopics
    :onlineUsers theOnline
    :messages theMessages
    :state state
