
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

  :propTypes $ {}
    :messages $ React.PropTypes.instanceOf Immutable.List

  :render $ \ ()
    div ({} (:className :message-list))
      this.props.messages.map $ \ (message)
        Message $ {} (:message message) (:key $ message.get :id)
