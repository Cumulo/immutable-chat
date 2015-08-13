
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :user-place

  :render $ \ ()
    div ({} (:className :user-place))
      , :user-place
