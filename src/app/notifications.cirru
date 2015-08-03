
var
  React $ require :react
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  div $ React.createFactory :div
  span $ React.createFactory :span

var T React.PropTypes

= module.exports $ React.createClass $ {}
  :displayName :app-notifications

  :propTypes $ {}
    :notifications $ T.instanceOf Immutable.List

  :render $ \ ()
    div ({} (:className :app-notifications))
      this.props.notifications.map $ \\ (item)
        div
          {}
            :key (item.get :id)
            :onClick this.onNotificationClick
            :className :notification
          span null (item.get :content)
