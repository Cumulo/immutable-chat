
var
  React $ require :react/addons
  Color $ require :color
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Lightbox $ React.createFactory $ require :react-origami-lightbox

var
  ({}~ div input) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :user-place
  :mixins $ []

  :propTypes $ {}
    :user $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired

  :getInitialState $ \ ()
    {} (:showLightbox false)
      :name $ this.props.user.get :name
      :avatar $ this.props.user.get :avatar

  :onLightboxShow $ \ ()
    this.setState $ {} (:showLightbox true)

  :onLightboxHide $ \ ()
    this.setState $ {} (:showLightbox false)

  :onNameChange $ \ (event)
    view.action $ {}
      :type :user/name
      :data event.target.value
    this.setState $ {} (:name event.target.value)

  :onAvatarChange $ \ (event)
    view.action $ {}
      :type :user/avatar
      :data event.target.value
    this.setState $ {} (:avatar event.target.value)

  :onMessageClear $ \ ()
    view.action $ {}
      :type :message/clear

  :renderLightbox $ \ ()
    Lightbox
      {} (:show this.state.showLightbox) (:onClose this.onLightboxHide)
      this.renderTable

  :renderTable $ \ ()
    div ({} (:className :as-table))
      div ({} (:className ":line as-hint")) :name:
      input $ {} (:className :as-value) (:value this.state.name)
        :onChange this.onNameChange
      div ({} (:className ":line as-hint")) :avatar:
      input $ {} (:className :as-value) (:value this.state.avatar)
        :onChange this.onAvatarChange
      div ({} (:style $ @stylePreview))
      div ({} (:style $ @styleControl))
        div
          {} (:style $ @styleDangerButton) (:onClick @onMessageClear)
          , ":clear messages totally!"

  :render $ \ ()
    div ({} (:style $ this.styleRoot))
      div
        {} (:className ":button is-attract") (:onClick this.onLightboxShow)
        , :settings
      this.renderLightbox

  :styleRoot $ \ ()
    {} (:height 40) (:color :white)

  :styleHint $ \ ()
    {}
      :color $ ... (Color) (hsl 0 0 20 0.8) (:hslString)

  :stylePreview $ \ ()
    {}
      :width :40px
      :height :40px
      :backgroundImage $ + ":url("
        @props.user.get :avatar
        , ":)"
      :backgroundSize :cover
      :display :inline-block
      :verticalAlign :middle
      :marginLeft :10px

  :styleControl $ \ ()
    {}
      :marginTop :80px

  :styleDangerButton $ \ ()
    {}
      :backgroundColor $ ... (Color) (hsl 0 80 80) (hslString)
      :display :inline-block
      :padding ":0 8px"
