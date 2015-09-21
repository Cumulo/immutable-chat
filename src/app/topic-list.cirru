
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
    :topics $ React.PropTypes.instanceOf Immutable.List

  :onTopicClick $ \ (topic)
    view.action $ {}
      :type :state/topic
      :data $ topic.get :id

  :styleRoot $ \ ()
    {} (:flex 1) (:position :relative)

  :styleContainer $ \ ()
    {} (:padding 10) (:height :100%)

  :styleCreator $ \ ()
    {} (:position :absolute) (:bottom 10) (:right 10)

  :render $ \ ()
    div ({} (:style $ this.styleRoot))
      div ({} (:style $ this.styleContainer))
        this.props.topics.map $ \\ (aTopic)
          var onClick $ \\ ()
            this.onTopicClick aTopic
          Topic $ {} (:topic aTopic) (:key $ aTopic.get :id)
            :onClick onClick
      div ({} (:style $ this.styleCreator))
        TopicCreator
