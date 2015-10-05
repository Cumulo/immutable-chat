
var
  React $ require :react
  Color $ require :color
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Member $ React.createFactory $ require :./member

var
  div $ React.createFactory :div
  img $ React.createFactory :img

= module.exports $ React.createClass $ {}
  :displayName :app-topic

  :propTypes $ {}
    :topic $ React.PropTypes.instanceOf Immutable.Map
    :onClick React.PropTypes.func.isRequired
    :isSubscribed React.PropTypes.bool.isRequired

  :onClick $ \ ()
    @props.onClick @props.topic

  :render $ \ ()
    div ({} (:onClick this.onClick) (:style (this.styleRoot)))
      cond (> @props.unread 0)
        cond @props.isSubscribed
          div ({} (:style $ @styleUnread)) @props.unread
          div ({} (:style $ @styleHint))
      div ({} (:style (this.styleText)))
        this.props.topic.get :text
      Member $ {}
        :member $ this.props.topic.get :userRef
        :showName false

  :styleRoot $ \ ()
    {} (:display :flex) (:flexDirection :row)
      :marginBottom 5
      :cursor :pointer
      :backgroundColor $ ... (Color) (hsl 0 0 100 0.9) (hslString)
      :alignItems :center

  :styleText $ \ ()
    {} (:flex 1) (:marginLeft 10)

  :styleUnread $ \ ()
    {}
      :padding ":0 8px"
      :backgroundColor $ ... (Color) (hsl 0 70 50) (hslString)
      :lineHeight :26px
      :height :26px
      :borderRadius :50%
      :color :white
      :marginLeft :10px

  :styleHint $ \ ()
    {}
      :width :10px
      :height :10px
      :backgroundColor $ ... (Color) (hsl 0 70 50) (hslString)
      :verticalAlign :middle
      :marginLeft :10px
      :borderRadius :50%
