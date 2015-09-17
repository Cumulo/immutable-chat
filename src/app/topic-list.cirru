
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

  :render $ \ ()
    div ({} (:className :topic-list))
      div ({} (:className :topic-container))
        this.props.topics.map $ \\ (aTopic)
          var onClick $ \\ ()
            this.onTopicClick aTopic
          Topic $ {} (:topic aTopic) (:key $ aTopic.get :id)
            :onClick onClick
      TopicCreator
