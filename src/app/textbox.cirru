
var
  React $ require :react
  keycode $ require :keycode

var
  view $ require :../frontend/view

var
  div $ React.createFactory :div
  textarea $ React.createFactory :textarea

= module.exports $ React.createClass $ {}
  :displayName :app-textbox

  :getInitialState $ \ ()
    {} (:text :)

  :onChange $ \ (event)
    this.setState $ {} (:text event.target.value)

  :onKeyDown $ \ (event)
    if
      and
        is (keycode event.keyCode) :enter
        or event.ctrlKey event.metaKey
      do
        view.action $ {}
          :type :message/create
          :data this.state.text
        this.setState $ {} (:text :)
    return undefined

  :render $ \ ()
    div ({})
      textarea $ {} (:value this.state.text)
        :onChange this.onChange
        :onKeyDown this.onKeyDown

