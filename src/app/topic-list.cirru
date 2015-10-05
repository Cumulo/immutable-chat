
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

  :render $ \ ()
    div ({} (:style $ this.styleRoot))
      div ({} (:style $ @styleControl))
        TopicCreator
      div ({} (:style $ this.styleContainer))
        ... @props.topics
          map $ \\ (aTopic)
            var
              topicId $ aTopic.get :id
            Topic $ {} (:topic aTopic) (:key topicId)
              :onClick @onTopicClick
              :unread $ or
                @props.unreads.get topicId
                , 0

  :styleRoot $ \ ()
    {} (:flex 1) (:position :relative)
      :overflow :auto
      :paddingTop :100px
      :paddingBottom :200px

  :styleContainer $ \ ()
    {} (:padding 10) (:height :100%)

  :styleControl $ \ ()
    {}
      :padding ":0 10px"
      :display :flex
      :flexDirection :row
      :justifyContent :flex-end
