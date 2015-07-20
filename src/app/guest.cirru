
var
  React $ require :react

var
  Login $ React.createFactory $ require :./login
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-guest

  :getInitialState $ \ ()
    return $ {}
      :isLogin true

  :render $ \ ()
    return $ div ({} (:className :app-guest))
      div ({} (:className :header))
