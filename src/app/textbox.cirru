
var
  React $ require :react
  keycode $ require :keycode
  Immutable $ require :immutable

var
  view $ require :../frontend/view

var
  div $ React.createFactory :div
  textarea $ React.createFactory :textarea

= module.exports $ React.createClass $ {}
  :displayName :app-textbox

  :propTypes $ {}

  :getInitialState $ \ ()
    {} (:text :)

  :onChange $ \ (event)
    this.setState $ {} (:text event.target.value)
    view.action $ {}
      :type :buffer/update
      :data $ {}
        :text event.target.value

  :onKeyDown $ \ (event)
    if
      and
        is (keycode event.keyCode) :enter
      do
        view.action $ {}
          :type :buffer/finish
          :data this.state.text
        this.setState $ {} (:text :)
        event.preventDefault
    , undefined

  :render $ \ ()
    div ({})
      textarea $ {} (:value this.state.text) (:style $ @styleText)
        :onChange this.onChange
        :onKeyDown this.onKeyDown

  :styleText $ \ ()
    {} (:margin :0px)
