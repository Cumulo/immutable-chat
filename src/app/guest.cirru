
var
  React $ require :react

var
  Login $ React.createFactory $ require :./login
  Signup $ React.createFactory $ require :./signup
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-guest

  :getInitialState $ \ ()
    return $ {}
      :atLogin true

  :render $ \ ()
    return $ div ({} (:className :app-guest))
      div ({} (:className :header)) ":Hello Guest"
      cond this.state.atLogin
        Login
        Signup