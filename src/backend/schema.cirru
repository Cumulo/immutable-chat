
var
  shortid $ require :shortid
  Immutable $ require :immutable

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

= exports.database $ Immutable.fromJS $ {}
  :tables $ {}
    :users $ []
      exports.user.merge $ Immutable.fromJS $ {}
        :id :Chatter
        :name :Chatter
        :password :Chatter
        :avatar :http://ww4.sinaimg.cn/thumb180/e8788f29gw1euzxos4oszj207h064jrn.jpg
        :isOnline :true
    :messages $ []
      exports.message.merge $ Immutable.fromJS $ {}
        :id (shortid.generate)
        :topidId :root
        :autherId :Chatter
        :time :2015-08-13T17:16:09.414Z
        :text ":Welcome to Chat, let's chat!"
        :isTopic true
    :buffers $ []
  :states $ {}
