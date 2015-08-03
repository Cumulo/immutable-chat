
var
  Immutable $ require :immutable

= exports.database $ Immutable.fromJS $ {}
  :tables $ {}
    :users $ []
    :messages $ []
    :buffers $ []
  :states $ {}

= exports.user $ Immutable.fromJS $ {}
  :id null
  :name null
  :password :password
  :avatar null
  :isOnline false

= exports.state $ Immutable.fromJS $ {}
  :id null
  :isFocused false
  :topicId null
  :notifications $ []
  :isLogined false
  :userId null

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

= exports.notification $ Immutable.fromJS $ {}
  :id null
  :text :empty
  :type :info
