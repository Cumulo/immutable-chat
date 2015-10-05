
var
  React $ require :react
  keycode $ require :keycode
  Immutable $ require :immutable

var
  view $ require :../frontend/view

var
  Member $ React.createFactory $ require :./member

var
  ({}~ div textarea) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-textbox

  :propTypes $ {}
    :user $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired

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
    div ({} (:style $ @styleRoot))
      Member $ {} (:member @props.user) (:showName false)
      textarea $ {} (:value this.state.text) (:style $ @styleText)
        :onChange this.onChange
        :onKeyDown this.onKeyDown
        :placeholder ":reply here..."

  :styleRoot $ \ ()
    {}
      :display :flex
      :flexDirection :row
      :marginBottom :5px

  :styleText $ \ ()
    {} (:margin :0px)
      :height :40px
      :lineHeight :40px
      :fontSize :16px
