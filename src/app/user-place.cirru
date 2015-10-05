
var
  React $ require :react/addons
  Color $ require :color
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Lightbox $ React.createFactory $ require :react-origami-lightbox

var
  ({}~ div span input) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :user-place
  :mixins $ []

  :propTypes $ {}
    :user $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired

  :getInitialState $ \ ()
    {} (:showLightbox false)
      :name $ this.props.user.get :name
      :avatar $ this.props.user.get :avatar
      :theme $ this.props.user.get :theme

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

  :onThemeChange $ \ (event)
    view.action $ {}
      :type :user/theme
      :data event.target.value
    @setState $ {} (:theme event.target.value)

  :onMessageClear $ \ ()
    view.action $ {}
      :type :message/clear

  :onLogout $ \ ()
    view.action $ {}
      :type :account/logout
    localStorage.setItem :immutable-chat-account :{}

  :renderLightbox $ \ ()
    Lightbox
      {} (:show this.state.showLightbox) (:onClose this.onLightboxHide)
      this.renderTable

  :renderTable $ \ ()
    div ({} (:className :as-table))
      div ({} (:style $ @styleControl))
        span ({} (:style $ @styleHint)) ":set name:"
        input $ {} (:className :as-value) (:value this.state.name)
          :onChange this.onNameChange
      div ({} (:style $ @styleControl))
        span ({} (:style $ @styleHint)) ":set avatar(use image url):"
        input $ {} (:className :as-value) (:value this.state.avatar)
          :onChange this.onAvatarChange
        div ({} (:style $ @stylePreview))
      div ({} (:style $ @styleControl))
        span ({} (:style $ @styleHint)) ":set theme(use image url):"
        input $ {} (:className :as-value) (:value @state.theme)
          :onChange this.onThemeChange
      div ({} (:style $ @styleControl))
        div
          {} (:style $ @styleDangerButton) (:onClick @onLogout)
          , ":logout"
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
    {} (:color :white)

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
      :marginTop :20px

  :styleDangerButton $ \ ()
    {}
      :backgroundColor $ ... (Color) (hsl 0 80 80) (hslString)
      :display :inline-block
      :padding ":0 8px"

  :styleHint $ \ ()
    {}
      :color $ ... (Color) (hsl 0 0 60) (hslString)