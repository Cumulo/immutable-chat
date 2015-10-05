
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Topic $ React.createFactory $ require :./topic
  TopicCreator $ React.createFactory $ require :./topic-creator

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :topic-list

  :propTypes $ {}
    :topics $ . (React.PropTypes.instanceOf Immutable.List) :isRequired
    :visits $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired
    :unreads $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired

  :onTopicClick $ \ (topic)
    view.action $ {}
      :type :state/topic
      :data $ topic.get :id

  :styleRoot $ \ ()
    {} (:flex 1) (:position :relative)

  :styleContainer $ \ ()
    {} (:padding 10) (:height :100%)
      :paddingBottom :200px
      :position :absolute
      :height :100%
      :width :100%
      :overflow :auto

  :styleCreator $ \ ()
    {} (:position :absolute) (:bottom 10) (:right 10)

  :render $ \ ()
    div ({} (:style $ this.styleRoot))
      div ({} (:style $ this.styleContainer))
        ... @props.topics
          reverse
          map $ \\ (aTopic)
            var
              topicId $ aTopic.get :id
            Topic $ {} (:topic aTopic) (:key topicId)
              :onClick @onTopicClick
              :unread $ or
                @props.unreads.get topicId
                , 0
          sortBy $ \ (el)
            - 0 el.props.unread
      div ({} (:style $ this.styleCreator))
        TopicCreator
