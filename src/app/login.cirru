
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
    {}
      :name :
      :password :

  :onSubmit $ \ (event)
    var accountInfo $ {}
      :name this.state.name
      :password this.state.password
    localStorage.setItem :immutable-chat-account
      JSON.stringify accountInfo
    view.action $ {}
      :type :account/login
      :data accountInfo

  :styleControl $ \ ()
    {} (:display :flex) (:justifyContent :flex-end)

  :render $ \ ()
    return $ div ({} (:className :app-login))
      div ({} (:className :line))
        span null :Username
        input $ {} (:type :text) (:valueLink $ this.linkState :name)
      div ({} (:className :line))
        span null :Password
        input $ {} (:type :password) (:valueLink $ this.linkState :password)
      div ({} (:style $ this.styleControl))
        div ({} (:className ":button is-attract") (:onClick this.onSubmit)) :Submit
