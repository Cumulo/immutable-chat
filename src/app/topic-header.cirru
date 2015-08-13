
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :topic-header

  :render $ \ ()
    div ({} (:className :topic-header))
      , :topic-header
