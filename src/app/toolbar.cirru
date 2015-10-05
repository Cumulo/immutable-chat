
var
  React $ require :react
  Color $ require :color
  Immutable $ require :immutable

var
  view $ require :../frontend/view

var
  UserPlace $ React.createFactory $ require :./user-place
  TopicCreator $ React.createFactory $ require :./topic-creator

var
  ({}~ div) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-toolbar

  :propTypes $ {}
    :user $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired

  :render $ \ ()
    div ({} (:style $ @styleRoot))
      TopicCreator
      UserPlace $ {} (:user @props.user)

  :styleRoot $ \ ()
    {}
      :display :flex
      :flexDirection :row
      :justifyContent :flex-start
      :alignItems :center
      :height :40px
      :marginTop :10px
      :backgroundColor $ ... (Color) (hsl 0 0 100 0.2) (hslString)
      :padding ":0 10px"
