
var
  React $ require :react/addons
  view $ require :../frontend/view

var
  div $ React.createFactory :div
  span $ React.createFactory :span
  input $ React.createFactory :input

var tag $ \ (className (children))
  div ({} (:className className)) (... children)

= module.exports $ React.createClass $ {}
  :displayName :login
  :mixins $ [] React.addons.LinkedStateMixin

  :getInitialState $ \ ()
    return $ {}
      :username :
      :password :

  :onSubmit $ \ (event)
    view.action $ {}
      :type :account/login
      :data $ {}
        :username this.state.username
        :password this.state.password

  :render $ \ ()
    return $ div ({} (:className :app-login))
      tag :line
        span null :Username
        input $ {} (:type :text) (:valueLink $ this.linkState :username)
      tag :line
        span null :Password
        input $ {} (:type :password) (:valueLink $ this.linkState :password)
      tag ":line control"
        div ({} (:className ":button is-attract") (:onClick this.onSubmit)) :Submit
