
= exports.toggle $ \ (db action)
  var
    stateId action.stateId
    userId $ db.getIn $ [] :states stateId :userId
    topicId $ db.getIn $ [] :states stateId :topicId
    dataPath $ [] :subscriptions userId topicId

  cond (? $ db.getIn dataPath)
    db.updateIn dataPath $ \ (status)
      not status
    db.setIn dataPath true
