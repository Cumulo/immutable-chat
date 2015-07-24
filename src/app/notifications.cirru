
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  div $ React.createFactory :div

var T React.PropTypes

= module.exports $ React.createClass $ {}
  :displayName :app-notifications

  :propTypes $ {}
    :notifications $ T.instanceOf Immutable.List

  :render $ \ ()
    return $ div ({} (:className :app-notifications))
      this.props.notifications.map $ \ (item)
        return $ div
          {}
            :key (item.get :id)
            :onClick this.onNotificationClick
            :className :notification
          span null (item.get :content)
