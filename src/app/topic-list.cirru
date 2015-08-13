
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Topic $ React.createFactory $ require :./topic

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :topic-list

  :propTypes $ {}
    :topics $ React.PropTypes.instanceOf Immutable.List

  :render $ \ ()
    div ({} (:className :topic-list))
      this.props.topics.map $ \ (aTopic)
        Topic $ {} (:topic aTopic) (:key $ aTopic.get :id)
