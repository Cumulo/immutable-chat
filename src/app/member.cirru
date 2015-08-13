
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-member

  :render $ \ ()
    div ({} (:className :app-member))
      , :app-member
