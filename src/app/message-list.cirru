
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
      @props.messages.map $ \\ (message)
        cond (message.get :isTopic)
          Topic $ {} (:unread 0) (:topic message) (:key $ message.get :id)
            :onClick @onTopicClick
          Message $ {} (:message message) (:key $ message.get :id)
      cond @props.showBox
        Textbox $ {}
        , undefined
      @props.buffers.map $ \ (buffer)
        Buffer $ {} (:buffer buffer) (:key $ buffer.get :id)

  :styleRoot $ \ ()
    {} (:flex 1)
      :height :100%
      :overflowY :auto
      :padding ":100px 10px 200px 10px"
