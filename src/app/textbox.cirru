
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
    :state $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired

  :getInitialState $ \ ()
    {} (:text :)

  :onChange $ \ (event)
    this.setState $ {} (:text event.target.value)
    if (> event.target.value.length 0) $ do
      view.action $ cond (? (@props.state.get :bufferId))
        {}
          :type :buffer/update
          :data $ {}
            :text event.target.value
        {}
          :type :buffer/create
          :data $ {}
            :text event.target.value
    , undefined

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
      textarea $ {} (:value this.state.text)
        :onChange this.onChange
        :onKeyDown this.onKeyDown
