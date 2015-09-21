
var
  React $ require :react/addons

var
  view $ require :../frontend/view

require :react-origami-lightbox/src/lightbox.css

var
  Lightbox $ React.createFactory $ require :react-origami-lightbox

var
  div $ React.createFactory :div
  textarea $ React.createFactory :textarea

= module.exports $ React.createClass $ {}
  :displayName :topic-creator
  :mixins $ [] React.addons.LinkedStateMixin

  :getInitialState $ \ ()
    {} (:showLightbox false) (:text :)

  :onLightboxClose $ \ ()
    this.setState $ {} (:showLightbox false)

  :onLightboxShow $ \ ()
    this.setState $ {} (:showLightbox true)

  :onSubmit $ \ ()
    view.action $ {}
      :type :message/topic
      :data $ {}
        :text this.state.text
    this.setState $ {} (:showLightbox false)

  :styleController $ \ ()
    {} (:display :flex) (:justifyContent :center) (:alignItems :center)

  :renderLightbox $ \ ()
    Lightbox
      {}
        :show this.state.showLightbox
        :onClose this.onLightboxClose
      this.renderDraft

  :renderDraft $ \ ()
    div ({} (:className :as-draft))
      textarea $ {} (:className :as-text)
        :valueLink $ this.linkState :text
      div ({} (:style $ this.styleController))
        div
          {} (:className ":button is-attract") (:onClick this.onSubmit)
          , :submit

  :render $ \ ()
    div ({} (:className :topic-creator))
      div
        {} (:className ":button is-attract") (:onClick this.onLightboxShow)
        , :add
      this.renderLightbox
