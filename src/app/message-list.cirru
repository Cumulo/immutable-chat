
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Topic $ React.createFactory $ require :./topic
  Buffer $ React.createFactory $ require :./buffer
  Member $ React.createFactory $ require :./member
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
    :listeners $ . (React.PropTypes.instanceOf Immutable.List) :isRequired
    :topicId React.PropTypes.string
    :user $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired
    :showBottom React.PropTypes.bool.isRequired

  :componentDidMount $ \ ()
    var
      node (@getDOMNode)
    if
      and @props.showBottom
        > node.scrollHeight
          + node.scrollTop node.clientHeight
      do
        = node.scrollTop node.scrollHeight
    , undefined

  :onTopicClick $ \ (topic)
    view.action $ {}
      :type :state/topic
      :data $ topic.get :id

  :render $ \ ()
    var
      userId $ @props.user.get :id

    div ({} (:style $ @styleRoot))
      @props.messages.map $ \\ (message)
        cond (message.get :isTopic)
          Topic $ {} (:unread 0) (:topic message) (:key $ message.get :id)
            :onClick @onTopicClick
          Message $ {} (:message message) (:key $ message.get :id)
      cond (? @props.topicId)
        Textbox $ {} (:user @props.user)
        , undefined
      div ({} (:style $ @styleListeners))
        @props.listeners.map $ \ (member)
          Member $ {} (:member member) (:showName false)
            :key $ member.get :id
      @props.buffers.map $ \ (buffer)
        cond (isnt (buffer.get :authorId) userId)
          Buffer $ {} (:buffer buffer) (:key $ buffer.get :id)

  :styleRoot $ \ ()
    {} (:flex 1)
      :height :100%
      :overflowY :auto
      :padding ":100px 10px 200px 10px"
      :maxWidth :800px

  :styleListeners $ \ ()
    {}
      :display :flex
      :flexDirection :row
      :marginTop :80px
