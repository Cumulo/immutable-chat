
var
  Immutable $ require :immutable
  backend $ require :../backend/schema

= exports.session $ Immutable.fromJS $ {}
  :password null
  :username null
  :topicId null

= exports.store $ Immutable.fromJS $ {}
  :topics $ []
  :messages $ []
  :onlineUsers $ []
  :state $ backend.private.toJS
