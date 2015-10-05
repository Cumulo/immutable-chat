
var
  React $ require :react
  view $ require :../frontend/view
  classnames $ require :classnames
  Immutable $ require :immutable

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-member

  :propTypes $ {}
    :member $ React.PropTypes.instanceOf Immutable.Map
    :showName React.PropTypes.bool.isRequired

  :render $ \ ()
    div ({} (:style $ this.styleRoot))
      div $ {} (:style (this.styleAvatar))
      cond @props.showName
        div ({} (:style $ @styleName)) $ @props.member.get :name
        , undefined

  :styleRoot $ \ ()
    {} (:display :flex) (:flexDirection :row) (:alignItems :flex-start)

  :styleAvatar $ \ ()
    {}
      :backgroundImage $ + ":url(" (this.props.member.get :avatar) ":)"
      :width 40
      :height 40
      :backgroundSize :cover

  :styleName $ \ ()
    {}
      :color :white
      :marginLeft :10px
      :overflow :hidden
      :textOverflow :ellipsis
