
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  div $ React.createFactory :div
  img $ React.createFactory :img

= module.exports $ React.createClass $ {}
  :displayName :app-topic

  :propTypes $ {}
    :topic $ React.PropTypes.instanceOf Immutable.Map

  :render $ \ ()
    div ({} (:className :app-topic))
      img ({} (:src $ this.props.topic.get :avatar))
