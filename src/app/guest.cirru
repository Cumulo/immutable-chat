
var
  React $ require :react
  color $ require :color

var
  Login $ React.createFactory $ require :./login
  Signup $ React.createFactory $ require :./signup
  OrigamiTabs $ React.createFactory $ require :react-origami-tabs
  div $ React.createFactory :div

var tabs $ [] ":login" ":signup"

= module.exports $ React.createClass $ {}
  :displayName :app-guest

  :getInitialState $ \ ()
    {}
      :tab $ . tabs 0

  :onSelect $ \ (tab)
    this.setState $ {} (:tab tab)

  :styleRoot $ \ ()
    {} (:width :100%) (:height :100%) (:display :flex)
      :justifyContent :center
      :alignItems :center

  :styleGuest $ \ ()
    {} (:padding ":0.5em 1em")
      :backgroundColor $ ... (color) (hsl 0 100 100 0.8) (hslString)
      :borderWidth 1
      :borderStyle :solid
      :borderColor $ ... (color) (hsl 240 80 92 1) (hslString)

  :render $ \ ()
    div ({} (:style $ this.styleRoot))
      div ({})
        OrigamiTabs $ {} (:tabs tabs) (:tab this.state.tab) (:onSelect this.onSelect)
        div ({} (:style $ this.styleGuest))
          case this.state.tab
            :login (Login)
            :signup (Signup)
