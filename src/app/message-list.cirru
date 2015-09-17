
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Message $ React.createFactory $ require :./message
  Textbox $ React.createFactory $ require :./textbox
  TopicHeader $ React.createFactory $ require :./topic-header

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :message-list

  :propTypes $ {}
    :messages $ React.PropTypes.instanceOf Immutable.List
    :showBox React.PropTypes.bool.isRequired

  :render $ \ ()
    div ({} (:className :message-list))
      div ({} (:className :message-table))
        this.props.messages.map $ \ (message)
          Message $ {} (:message message) (:key $ message.get :id)
      cond this.props.showBox
        Textbox
        , undefined
