
var
  React $ require :react/addons
  color $ require :color
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Lightbox $ React.createFactory $ require :react-origami-lightbox

var
  div $ React.createFactory :div
  input $ React.createFactory :input

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

  :styleRoot $ \ ()
    {} (:height 40) (:color :white)

  :styleHint $ \ ()
    {}
      :color $ ... (color) (hsl 0 0 20 0.8) (:hslString)

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

  :render $ \ ()
    div ({} (:style $ this.styleRoot))
      div
        {} (:className ":button is-attract") (:onClick this.onLightboxShow)
        , :settings
      this.renderLightbox
