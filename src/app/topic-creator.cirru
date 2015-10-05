
var
  React $ require :react/addons
  Color $ require :color

var
  view $ require :../frontend/view

require :react-origami-lightbox/src/lightbox.css

var
  Lightbox $ React.createFactory $ require :react-origami-lightbox

var
  ({}~ div span textarea) React.DOM

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
    var text
      this.state.text.trim
    if (> text.length 0) $ do
      view.action $ {}
        :type :message/topic
        :data $ {}
          :text @state.text
      @setState $ {} (:showLightbox false) (:text :)
    , undefined

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
          , ":create topic"
      div ({} (:style $ this.styleController))
        span ({} (:style $ @styleHint)) ":also turn messages into topics from message drop menu"

  :render $ \ ()
    div ({} (:className :topic-creator))
      div ({} (:style $ @styleButton) (:onClick this.onLightboxShow)) ":new topic"
      @renderLightbox

  :styleController $ \ ()
    {} (:display :flex) (:justifyContent :flex-start) (:alignItems :center)

  :styleHint $ \ ()
    {}
      :color $ ... (Color) (hsl 0 0 80) (hslString)

  :styleButton $ \ ()
    {}
      :color :white
      :display :inline-block
      :backgroundColor $ ... (Color) (hsl 240 80 76) (hslString)
      :fontSize :12px
      :padding ":0 8px"
      :cursor :pointer
      :marginRight :10px
