
var
  React $ require :react
  Color $ require :color

var
  ({}~ div) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-dialog

  :propTypes $ {}
    :onClose React.PropTypes.func.isRequired

  :onBoxClick $ \ (event)
    event.stopPropagation

  :onShadowClick $ \ (event)
    @props.onClose

  :render $ \ ()
    div ({} (:style $ @styleRoot) (:onClick @onShadowClick))
      div ({} (:style $ @styleBox) (:onClick @onBoxClick))
        , @props.children

  :styleRoot $ \ ()
    {}
      :position :fixed
      :top :0px
      :left :0px
      :width :100%
      :height :100%
      :backgroundColor $ ... (Color) (hsl 0 0 30 0.6) (hslString)
      :display :flex
      :flexDirection :column
      :justifyContent :center
      :alignItems :center

  :styleBox $ \ ()
    {}
      :width :300px
      :height :200px
      :backgroundColor $ ... (Color) (hsl 0 100 100) (hslString)
      :display :flex
      :flexDirection :column
      :justifyContent :center
      :alignItems :center
