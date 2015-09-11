
var
  React $ require :react

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

  :render $ \ ()
    div ({} (:className :app-textbox))
      textarea $ {} (:value this.state.text)
        :onChange this.onChange
