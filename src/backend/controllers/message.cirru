
= exports.promote $ \ (db action)
  db.updateIn ([] :tables :messages) $ \ (messages)
    messages.map $ \ (aMessage)
      cond (is (aMessage.get :id) action.data)
        aMessage.set :isTopic true
        , aMessage
