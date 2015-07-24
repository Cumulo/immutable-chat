
var
  React $ require :react
  Pipeline $ require :../util/pipeline
  view $ require :../frontend/view
  schema $ require :../frontend/schema

var
  Guest $ React.createFactory $ require :./guest
  Notifications $ React.createFactory $ require :./notifications
  div $ React.createFactory :div

var pageComponent $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    return $ {}
      :store schema.store
      :session schema.session

  :componentWillMount $ \ ()
    Pipeline.for view.in $ \\ (data)
      if (is data.target :store) $ do
        this.setState $ {} $ :store data.data
    Pipeline.for view.in $ \\ (data)
      if (is data.target :session) $ do
        this.setState $ {} $ :session data.data

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
