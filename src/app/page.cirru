
var
  React $ require :react
  store $ require :../app/store
  session $ require :../app/session
  stream $ require :../util/stream

var
  ({}~ handleStream) stream

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    return $ {}
      :store null
      :session null

  :componentWillMount $ \ ()
    handleStream store $ \\ (data)
      this.setState $ {} (:store data)
    handleStream session $ \\ (data)
      this.setState $ {} (:session data)

  :render $ \ ()
    div null :demo
