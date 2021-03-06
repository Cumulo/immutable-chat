
var
  Immutable $ require :immutable
  Pipeline $ require :cumulo-pipeline
  schema $ require :./schema
  fs $ require :fs
  path $ require :path
  userController $ require :./controllers/user
  bufferController $ require :./controllers/buffer
  messageController $ require :./controllers/message
  stateController $ require :./controllers/state
  accountController $ require :./controllers/account
  subscribeController $ require :./controllers/subscribe

= exports.in $ new Pipeline

var dbpath $ path.join __dirname :data.json
if (fs.existsSync dbpath)
  do
    var content $ JSON.parse $ fs.readFileSync dbpath :utf8
    = content.states $ {}
    = content.buffers $ {}
    var _database $ Immutable.fromJS content
    = _database $ _database.update :users $ \ (user)
      user.set :isOnline false
  do
    var _database $ Immutable.fromJS schema.database

= exports.out $ exports.in.reduce _database $ \ (db action)
  var
    stateId action.stateId
  case action.type
    :account/signup $ accountController.signup db action
    :account/login $ accountController.login db action
    :account/logout $ accountController.logout db action

    :state/connect $ stateController.connect db action
    :state/disconnect $ stateController.disconnect db action
    :state/focus $ stateController.focus db action
    :state/blur $ stateController.blur db action
    :state/check $ stateController.check db action
    :state/topic $ stateController.topic db action

    :user/update $ userController.update db action
    :user/name $ userController.name db action
    :user/avatar $ userController.avatar db action
    :user/theme $ userController.theme db action

    :message/promote $ messageController.promote db action
    :message/topic $ messageController.topic db action
    :message/create $ messageController.create db action
    :message/clear $ messageController.clear db action

    :buffer/update $ bufferController.update db action
    :buffer/finish $ bufferController.finish db action

    :subscribe/toggle $ subscribeController.toggle db action

    else db
