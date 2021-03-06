
var
  Immutable $ require :immutable

= exports.user $ Immutable.fromJS $ {}
  :id null
  :name null
  :password :password
  :avatar :http://tp2.sinaimg.cn/1402618461/180/0/1
  :isOnline false
  :theme null

= exports.state $ Immutable.fromJS $ {}
  :id null
  :isFocused false
  :topicId null
  :notifications $ []
  :userId null
  :showBottom false

= exports.buffer $ Immutable.fromJS $ {}
  :id null
  :topicId null
  :authorId null
  :time null
  :text null
  :isTopic false

= exports.message $ Immutable.fromJS $ {}
  :id null
  :topicId null
  :authorId null
  :time null
  :lastTouch null
  :text null
  :isTopic false

= exports.notification $ Immutable.fromJS $ {}
  :id null
  :text :empty
  :type :info

= exports.database $ Immutable.fromJS $ {}
  :users $ []
  :messages $ []
  :buffers $ {}
  :visits $ {}
  :states $ {}

= exports.store $ Immutable.fromJS $ {}
  :topics $ []
  :messages $ []
  :unreads $ {}
  :subscriptions $ {}
  :buffers $ []
  :user null
  :onlineUsers $ []
  :listeners $ []
  :state exports.state
