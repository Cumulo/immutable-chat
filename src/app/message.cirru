
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Member $ React.createFactory $ require :./member
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-message

  :propTypes $ {}
    :message $ React.PropTypes.instanceOf Immutable.Map

  :onPromote $ \ ()
    view.action $ {}
      :type :message/promote
      :data $ this.props.message.get :id

  :render $ \ ()
    var message this.props.message

    div ({} (:className :app-message))
      Member $ {} (:member $ message.get :userRef)
      div ({} (:className :message-text))
        message.get :text
      cond (message.get :isTopic)
        div ({} (:className :as-label)) :T
        div
          {} (:className ":button is-minor") (:onClick this.onPromote)
          , :T
