
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

  :render $ \ ()
    div ({} (:className :app-message))
      Member $ {} (:member $ this.props.message.get :userRef)
      div ({} (:className :message-text))
        this.props.message.get :text

