
var
  React $ require :react
  Pipeline $ require :cumulo-pipeline
  schema $ require :../frontend/schema
  view $ require :../frontend/view

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

  :render $ \ ()
    var isUserLogined $ ? $ ... this.state.store
      get :state
      get :userId
    div ({} (:className :app-page))
      cond isUserLogined
        Meeting $ {} (:store this.state.store)
        Guest
      Notis $ {}
        :notifications $ this.state.store.getIn $ [] :state :notifications
        :onClick this.onNotisClick

var
  Page $ React.createFactory pageComponent

React.render (Page) document.body
