
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

  :render $ \ ()
    var className $ classnames :app-member :line $ {}
      :is-online $ this.props.member.get :isOnline

    div ({} (:className className))
      div $ {} (:className :member-avatar)
        :style $ {} $ :backgroundImage
          + ":url(" (this.props.member.get :avatar) ":)"
      div ({} (:className :member-name)) (this.props.member.get :name)
