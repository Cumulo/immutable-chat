
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
    :members $ . (React.PropTypes.instanceOf Immutable.List) :isRequired
    :user $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired

  :render $ \ ()
    div ({} (:style $ @styleRoot))
      div ({} (:style $ @styleTable))
        @props.members.map $ \\ (member)
          div ({} (:style $ @styleWrapper))
            Member $ {} (:member member) (:key $ member.get :id) (:showName true)
      UserPlace $ {} (:user @props.user)

  :styleRoot $ \ ()
    {} (:width 200) (:display :flex) (:flexDirection :column)

  :styleTable $ \ ()
    {} (:flex 1)

  :styleWrapper $ \ ()
    {}
      :padding ":3px 0px"