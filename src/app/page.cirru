
var
  React $ require :react
  store $ require :../frontend/store
  session $ require :../frontend/session
  Stream $ require :../util/stream

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    return $ {}
      :store null
      :session null

  :componentWillMount $ \ ()
    Stream.handle store $ \\ (data)
      this.setState $ {} (:store data)
    Stream.handle session $ \\ (data)
      this.setState $ {} (:session data)

  :render $ \ ()
    return $ div null :demo
