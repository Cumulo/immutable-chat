
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Topic $ React.createFactory $ require :./topic
  Buffer $ React.createFactory $ require :./buffer
  Message $ React.createFactory $ require :./message
  Textbox $ React.createFactory $ require :./textbox
  TopicHeader $ React.createFactory $ require :./topic-header

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :message-list

  :propTypes $ {}
    :messages $ . (React.PropTypes.instanceOf Immutable.List) :isRequired
    :buffers $ . (React.PropTypes.instanceOf Immutable.List) :isRequired
    :showBox React.PropTypes.bool.isRequired

  :onTopicClick $ \ (topic)
    view.action $ {}
      :type :state/topic
      :data $ topic.get :id

  :render $ \ ()
    div ({} (:style $ @styleRoot))
      div ({} (:style $ @styleTable))
        @props.messages.map $ \\ (message)
          cond (message.get :isTopic)
            Topic $ {} (:unread 0) (:topic message) (:key $ message.get :id)
              :onClick @onTopicClick
            Message $ {} (:message message) (:key $ message.get :id)
        @props.buffers.map $ \ (buffer)
          Buffer $ {} (:buffer buffer) (:key $ buffer.get :id)
      cond @props.showBox
        Textbox $ {}
        , undefined

  :styleRoot $ \ ()
    {} (:flex 1) (:padding 10) (:display :flex) (:flexDirection :column)
      :height :100%

  :styleTable $ \ ()
    {} (:flex 1) (:overflowX :hidden) (:overflowY :auto)
      :paddingBottom :200px
