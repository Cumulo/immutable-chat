
var
  React $ require :react
  color $ require :color
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Member $ React.createFactory $ require :./member
  Dialog $ React.createFactory $ require :../module/dialog

var
  ({}~ div) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-message

  :propTypes $ {}
    :message $ React.PropTypes.instanceOf Immutable.Map

  :getInitialState $ \ ()
    {}
      :showMenu false

  :onPromote $ \ ()
    view.action $ {}
      :type :message/promote
      :data $ this.props.message.get :id

  :onMenuHide $ \ () (@setState ({} (:showMenu false)))

  :onContextMenu $ \ (event)
    event.preventDefault
    @setState $ {} (:showMenu true)

  :renderMenu $ \ ()
    Dialog ({} (:onClose @onMenuHide))
      cond (not $ @props.message.get :isTopic)
        div ({} (:style $ @styleMenuItem) (:onClick this.onPromote))
          , ":turn into topic"

  :render $ \ ()
    var message this.props.message

    div ({} (:style $ this.styleRoot) (:onContextMenu @onContextMenu))
      Member $ {} (:member $ message.get :userRef) (:showName false)
      div ({} (:style $ this.styleText))
        message.get :text
      cond @state.showMenu
        @renderMenu

  :styleRoot $ \ ()
    {} (:display :flex) (:flexDirection :row)
      :backgroundColor $ ... (color) (hsl 0 100 100 0.9) (hslString)
      :marginBottom 5

  :styleText $ \ ()
    {} (:flex 1) (:marginLeft 10)
      :maxHeight :200px

  :styleMenuItem $ \ ()
    {}
      :backgroundColor $ ... (color) (hsl 240 80 80) (hslString)
      :color :white
      :padding ":0 10px"
      :cursor :pointer
