
var
  React $ require :react
  Pipeline $ require :../util/pipeline
  view $ require :../frontend/view
  schema $ require :../frontend/schema

var
  div $ React.createFactory :div

var pageComponent $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    return $ {}
      :store null
      :session schema.session

  :componentWillMount $ \ ()
    Pipeline.for view.in $ \\ (data)
      if (is data.target :store) $ do
        this.setState $ {} $ :store data.data
    Pipeline.for view.in $ \\ (data)
      if (is data.target :session) $ do
        this.setState $ {} $ :session data.data

  :render $ \ ()
    return $ div null :demo

var
  Page $ React.createFactory pageComponent

React.render (Page) document.body
