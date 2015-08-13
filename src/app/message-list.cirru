
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Message $ React.createFactory $ require :./message
  TopicHeader $ React.createFactory $ require :./topic-header

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :message-list

  :render $ \ ()
    div ({} (:className :message-list))
      , :message-list
