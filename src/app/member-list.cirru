
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :member-list

  :render $ \ ()
    div ({} (:className :member-list))
      , :member-list
