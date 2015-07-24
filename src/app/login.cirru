
var
  React $ require :react/addons
  view $ require :../frontend/view

var
  div $ React.createFactory :div
  span $ React.createFactory :span
  input $ React.createFactory :input

= module.exports $ React.createClass $ {}
  :displayName :login
  :mixins $ [] React.addons.LinkedStateMixin

  :getInitialState $ \ ()
    return $ {}
      :username :
      :password :

  :onSubmit $ \ (event)
    view.action $ {}
      :type :user/login
      :data $ {}
        :username this.state.username
        :password this.state.password

  :render $ \ ()
    return $ div ({} (:className :page-login))
      div ({} (:className :line))
        span null ":Log in"
      div ({} (:className :line))
        span null :Username
        input $ {} (:type :text) (:valueLink $ this.linkState :username)
      div ({} (:className :line))
        span null :Password
        input $ {} (:type :password) (:valueLink $ this.linkState :password)
      div ({} (:className :line))
        div ({} (:className :button) (:onClick this.onSubmit)) :Submit
