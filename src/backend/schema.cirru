
var
  Immutable $ require :immutable

= exports.database $ Immutable.fromJS $ {}
  :tables $ {}
    :users $ []
    :messages $ []
    :buffers $ []
  :privates $ {}

= exports.user $ Immutable.fromJS $ {}
  :name null
  :password :password
  :avatar null
  :isOnline

= exports.private $ Immutable.fromJS $ {}
  :isFocused false

= exports.buffer $ Immutable.fromJS $ {}
  :id null
  :topidId null
  :autherId null
  :time null
  :text null

= exports.message $ Immutable.fromJS $ {}
  :id null
  :topidId null
  :autherId null
  :time null
  :text null
  :isTopic false