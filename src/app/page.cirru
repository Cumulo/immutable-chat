
var
  React $ require :react
  Pipeline $ require :cumulo-pipeline
  schema $ require :../frontend/schema

= exports.in $ new Pipeline

var
  Guest $ React.createFactory $ require :./guest
  Notifications $ React.createFactory $ require :./notifications
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

  :render $ \ ()
    return $ div ({} (:className :app-page))
      Guest
      Notifications $ {}
        :notifications $ ... this.state.store
          get :state
          get :notifications

var
  Page $ React.createFactory pageComponent

React.render (Page) document.body
