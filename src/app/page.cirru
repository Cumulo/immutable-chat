
var
  React $ require :react
  Pipeline $ require :cumulo-pipeline
  schema $ require :../backend/schema
  view $ require :../frontend/view
  bgOuterSpace $ require :../../images/outer-space.jpg

= exports.in $ new Pipeline

var
  Guest $ React.createFactory $ require :./guest
  Notis $ React.createFactory $ require :react-origami-notifications
  Meeting $ React.createFactory $ require :./meeting
  div $ React.createFactory :div

var pageComponent $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    return $ {}
      :store schema.store

  :componentWillMount $ \ ()
    exports.in.for $ \\ (data)
      if (is data.target :store) $ do
        this.setState $ {} $ :store data.data
      return

  :onNotisClick $ \ (id)
    view.action $ {} (:type :state/check) (:data id)

  :styleRoot $ \ ()
    var
      theme $ or
        @state.store.getIn $ [] :user :theme
        , bgOuterSpace
    {} (:width :100%) (:height :100%)
      :backgroundImage $ + ":url(" theme ":)"
      :backgroundSize :cover
      :fontFamily ":Verdana, MicroSoft Yahei, Helvetica, sans-serif"

  :render $ \ ()
    var isUserLogined $ ? $ ... this.state.store
      get :state
      get :userId

    div ({} (:style $ this.styleRoot))
      cond isUserLogined
        Meeting $ {} (:store this.state.store)
        Guest
      Notis $ {}
        :notifications $ this.state.store.getIn $ [] :state :notifications
        :onClick this.onNotisClick

var
  Page $ React.createFactory pageComponent

React.render (Page) document.body
