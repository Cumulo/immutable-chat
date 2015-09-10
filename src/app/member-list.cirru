
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Member $ React.createFactory $ require :./member
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :member-list

  :propTypes $ {}
    :members $ React.PropTypes.instanceOf Immutable.List

  :render $ \ ()
    div ({} (:className :member-list))
      this.props.members.map $ \ (member)
        Member $ {} (:member member) (:key $ member.get :id)
