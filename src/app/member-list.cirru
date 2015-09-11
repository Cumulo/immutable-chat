
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Member $ React.createFactory $ require :./member
  UserPlace $ React.createFactory $ require :./user-place
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :member-list

  :propTypes $ {}
    :members $ React.PropTypes.instanceOf Immutable.List

  :render $ \ ()
    div ({} (:className :member-list))
      div ({} (:className :member-table))
        this.props.members.map $ \ (member)
          Member $ {} (:member member) (:key $ member.get :id)
      UserPlace
