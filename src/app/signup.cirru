
var
  React $ require :react/addons
  view $ require :../frontend/view

var
  div $ React.createFactory :div
  span $ React.createFactory :span
  input $ React.createFactory :input

= module.exports $ React.createClass $ {}
  :displayName :app-signup
  :mixins $ [] React.addons.LinkedStateMixin

  :getInitialState $ \ ()
    return $ {}
      :name :
      :password :

  :onSubmit $ \ ()
    view.action $ {}
      :type :account/signup
      :data $ {}
        :name this.state.name
        :password this.state.password

  :styleControl $ \ ()
    {} (:display :flex) (:justifyContent :flex-end)

  :render $ \ ()
    div ({} (:className :app-signup))
      div ({} (:className :line))
        span null :Username
        input $ {} (:type :text) (:valueLink $ this.linkState :name)
      div ({} (:className :line))
        span null :Password
        input $ {} (:type :text) (:valueLink $ this.linkState :password)
      div ({} (:style $ this.styleControl))
        div ({} (:className ":button is-attract") (:onClick this.onSubmit)) :Submit
