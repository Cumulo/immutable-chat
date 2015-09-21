
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

  :styleRoot $ \ ()
    {} (:flex 1) (:padding 10) (:display :flex) (:flexDirection :column)

  :styleTable $ \ ()
    {} (:flex 1) (:overflowX :hidden) (:overflowY :auto)

  :render $ \ ()
    div ({} (:style $ this.styleRoot))
      div ({} (:style $ this.styleTable))
        this.props.messages.map $ \ (message)
          Message $ {} (:message message) (:key $ message.get :id)
      cond this.props.showBox
        Textbox
        , undefined
