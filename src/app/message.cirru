
var
  React $ require :react
  color $ require :color
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Member $ React.createFactory $ require :./member
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-message

  :propTypes $ {}
    :message $ React.PropTypes.instanceOf Immutable.Map

  :onPromote $ \ ()
    view.action $ {}
      :type :message/promote
      :data $ this.props.message.get :id

  :styleRoot $ \ ()
    {} (:display :flex) (:flexDirection :row)
      :backgroundColor $ ... (color) (hsl 0 100 100 0.9) (hslString)
      :marginBottom 5

  :styleText $ \ ()
    {} (:flex 1) (:marginLeft 10)
      :maxHeight :200px

  :render $ \ ()
    var message this.props.message

    div ({} (:style $ this.styleRoot))
      Member $ {} (:member $ message.get :userRef) (:showName false)
      div ({} (:style $ this.styleText))
        message.get :text
      cond (message.get :isTopic)
        div ({}) :T
        div
          {} (:className ":button is-minor") (:onClick this.onPromote)
          , :T
