
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Member $ React.createFactory $ require :./member

var
  div $ React.createFactory :div
  img $ React.createFactory :img

= module.exports $ React.createClass $ {}
  :displayName :app-topic

  :propTypes $ {}
    :topic $ React.PropTypes.instanceOf Immutable.Map

  :render $ \ ()
    div ({} (:className ":app-topic line"))
      Member $ {}
        :member $ this.props.topic.get :userRef
      div ({} (:className :topic-text))
        this.props.topic.get :text
