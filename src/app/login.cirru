
var
  React $ require :react/addons
  view $ require :../frontend/view

var
  div $ React.createFactory :div
  input $ React.createFactory :input

= module.exports $ React.createClass $ {}
  :displayName :login
  :mixins $ [] React.addons.LinkedStateMixin

  :getInitialState $ \ ()
    return $ {}
      :username :
      :password :

  :onSubmit $ \ (event)
    if
      and (> this.state.username.length 0)
        > this.state.password.length 0
      do
        console.log :submit

  :render $ \ ()
    return $ div ({} (:className :page-login))
      div ({} (:className :line))
        span null :Username
        input $ {}
          :type :text
          :valueLink $ this.linkState :username
      div ({} (:className :line))
        span null :Password
        input $ {}
          :type :password
          :valueLink $ this.linkState :password
      div ({} (:className :line))
        div ({} (:className :button) (:onClick this.onSubmit)) :Submit