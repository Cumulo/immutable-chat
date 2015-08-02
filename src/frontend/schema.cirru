
var
  Immutable $ require :immutable
  backend $ require :../backend/schema

= exports.store $ Immutable.fromJS $ {}
  :topics $ []
  :messages $ []
  :onlineUsers $ []
  :state $ backend.private.toJS
