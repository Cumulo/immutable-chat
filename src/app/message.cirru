
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-message

  :render $ \ ()
    div ({} (:className :app-message))
      , :app-message
