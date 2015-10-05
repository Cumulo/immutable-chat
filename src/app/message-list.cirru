
var
  React $ require :react
  Color $ require :color
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
    :isSubscribed React.PropTypes.bool.isRequired

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

  :onSubscribeToggle $ \ ()
    view.action $ {}
      :type :subscribe/toggle

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
      @props.buffers.map $ \ (buffer)
        cond (isnt (buffer.get :authorId) userId)
          Buffer $ {} (:buffer buffer) (:key $ buffer.get :id)
      div ({} (:style $ @styleListeners))
        @props.listeners.map $ \ (member)
          Member $ {} (:member member) (:showName false)
            :key $ member.get :id
      div ({} (:style $ @styleControl))
        div
          {} (:style $ @styleButton @props.isSubscribed)
            :onClick @onSubscribeToggle
          , :subscribe

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

  :styleControl $ \ ()
    {}
      :marginTop :10px

  :styleButton $ \ (status)
    {}
      :color :white
      :backgroundColor $ cond status
        ... (Color) (hsl 200 40 80 0.6) (hslString)
        ... (Color) (hsl 200 40 80 0.2) (hslString)
      :display :inline-block
      :padding ":0 10px"
      :lineHeight :30px
      :cursor :pointer
