
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Toolbar $ React.createFactory $ require :./toolbar
  TopicList $ React.createFactory $ require :./topic-list
  MemberList $ React.createFactory $ require :./member-list
  MessageList $ React.createFactory $ require :./message-list

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-meeting

  :propTypes $ {}
    :store $ React.PropTypes.instanceOf Immutable.Map

  :getInitialState $ \ ()
    {}
      :portalHeight $ - window.innerHeight 50
      :showTopics true
      :showMembers true

  :componentDidMount $ \ ()
    window.addEventListener :resize @onResize

  :componentWillUnmount $ \ ()
    window.removeEventListener :resize @onResize

  :onResize $ \ (event)
    @setState $ {}
      :portalHeight $ - window.innerHeight 50

  :onTopicsToggle $ \ ()
    @setState $ {}
      :showTopics $ not @state.showTopics

  :onMembersToggle $ \ ()
    @setState $ {}
      :showMembers $ not @state.showMembers

  :render $ \ ()
    var
      store @props.store

    div ({} (:style $ @styleRoot))
      div ({} (:style $ @stylePortal))
        cond @state.showTopics $ TopicList $ {}
          :topics $ store.get :topics
          :visits $ store.get :visits
          :unreads $ store.get :unreads
        MessageList $ {}
          :messages $ store.get :messages
          :buffers $ store.get :buffers
          :showBox $ ? $ store.getIn
            [] :state :topicId
        cond @state.showMembers $ MemberList $ {}
          :members $ store.get :members
          :user $ store.get :user
      Toolbar $ {} (:user $ store.get :user)
        :showTopics @state.showTopics
        :showMembers @state.showMembers
        :onMembersToggle @onMembersToggle
        :onTopicsToggle @onTopicsToggle

  :styleRoot $ \ ()
    {} (:display :flex) (:flexDirection :column)
      :position :absolute
      :width :100%
      :height :100%

  :stylePortal $ \ ()
    {} (:display :flex) (:flexDirection :row)
      :height @state.portalHeight
      :justifyContent :center
