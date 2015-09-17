
var
  Immutable $ require :immutable

= module.exports $ \ (db state)
  Immutable.Map $ {}
    :topics $ ... db
      getIn $ [] :tables :messages
      filter $ \ (aMessage) (aMessage.get :isTopic)
      map $ \ (aMessage)
        var theUser $ ... db
          getIn $ [] :tables :users
          find $ \ (aUser)
            console.log (aUser.get :id) (aMessage.get :authorId)
            is (aUser.get :id) (aMessage.get :authorId)
        console.log :theUser theUser
        aMessage.set :userRef theUser
    :members $ ... db
      getIn $ [] :tables :users
      filter $ \ (aUser) (aUser.get :isOnline)
    :messages $ ... db
      getIn $ [] :tables :messages
      filter $ \ (aMessage)
        or
          is (aMessage.get :id) (state.get :topicId)
          is (aMessage.get :topicId) (state.get :topicId)
      map $ \ (aMessage)
        var theUser $ ... db (getIn $ [] :tables :users)
          find $ \ (aUser) $ is (aUser.get :id) (aMessage.get :authorId)
        aMessage.set :userRef theUser
    :state state
    :user $ ... db
      getIn $ [] :tables :users
      find $ \ (user)
        console.log (user.get :id) (state.get :userId)
        is (user.get :id) (state.get :userId)
