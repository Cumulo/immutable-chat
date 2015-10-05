
var
  React $ require :react
  Color $ require :color
  assign $ require :object-assign
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
    :showTopics React.PropTypes.bool.isRequired
    :showMembers React.PropTypes.bool.isRequired
    :onTopicsToggle React.PropTypes.func.isRequired
    :onMembersToggle React.PropTypes.func.isRequired

  :onTopicsToggle $ \ ()
    @props.onTopicsToggle

  :onMembersToggle $ \ ()
    @props.onMembersToggle

  :render $ \ ()
    div ({} (:style $ @styleRoot))
      TopicCreator
      UserPlace $ {} (:user @props.user)
      div
        {} (:style $ @styleToggler @props.showTopics)
          :onClick @onTopicsToggle
        , ":show topics"
      div
        {} (:style $ @styleToggler @props.showMembers)
          :onClick @onMembersToggle
        , ":show members"

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

  :styleToggler $ \ (status)
    assign
      {}
        :display :inline-block
        :fontSize :12px
        :color :white
        :marginLeft :10px
        :padding ":0 10px"
        :cursor :pointer
      cond status
        {}
          :backgroundColor $ ... (Color) (hsl 200 70 90 0.5) (hslString)
        {}
          :backgroundColor $ ... (Color) (hsl 200 70 90 0.2) (hslString)
