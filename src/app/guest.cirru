
var
  React $ require :react

var
  Login $ React.createFactory $ require :./login
  Signup $ React.createFactory $ require :./signup
  OrigamiTabs $ React.createFactory $ require :react-origami-tabs
  div $ React.createFactory :div

var tag $ \ (className (children))
  div ({} (:className className)) (... children)

var tabs $ [] ":login" ":signup"

= module.exports $ React.createClass $ {}
  :displayName :app-guest

  :getInitialState $ \ ()
    return $ {}
      :tab $ . tabs 0

  :onSelect $ \ (tab)
    this.setState $ {} (:tab tab)

  :render $ \ ()
    tag :app-guest
      tag :guest-board
        OrigamiTabs $ {} (:tabs tabs) (:tab this.state.tab) (:onSelect this.onSelect)
        tag :guest-view
          case this.state.tab
            :login (Login)
            :signup (Signup)
