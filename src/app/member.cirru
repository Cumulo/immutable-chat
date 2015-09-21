
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

  :styleRoot $ \ ()
    {} (:display :flex) (:flexDirection :row) (:alignItems :center)

  :styleAvatar $ \ ()
    {}
      :backgroundImage $ + ":url(" (this.props.member.get :avatar) ":)"
      :width 40
      :height 40
      :backgroundSize :cover

  :render $ \ ()
    div ({} (:style $ this.styleRoot))
      div $ {} (:style (this.styleAvatar))
