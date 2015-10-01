
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  TopicList $ React.createFactory $ require :./topic-list
  MemberList $ React.createFactory $ require :./member-list
  MessageList $ React.createFactory $ require :./message-list

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-meeting

  :propTypes $ {}
    :store $ React.PropTypes.instanceOf Immutable.Map

  :styleRoot $ \ ()
    {} (:display :flex) (:flexDirection :row) (:alignItems :stretch)
      :position :absolute
      :width :100%
      :height :100%

  :render $ \ ()
    var
      store @props.store

    div ({} (:style $ this.styleRoot))
      TopicList $ {}
        :topics $ store.get :topics
        :visits $ store.get :visits
        :unreads $ store.get :unreads
      MessageList $ {}
        :messages $ store.get :messages
        :buffers $ store.get :buffers
        :showBox $ ? $ store.getIn
          [] :state :topicId
      MemberList $ {}
        :members $ store.get :members
        :user $ store.get :user
