
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  TopicList $ React.createFactory $ require :./topic-list
  MemberList $ React.createFactory $ require :./member-list
  MessageList $ React.createFactory $ require :./message-list

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-meeting

  :render $ \ ()
    div ({} (:className :app-meeting))
      TopicList
      MessageList
      MemberList

