
var
  React $ require :react
  color $ require :color
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Member $ React.createFactory $ require :./member

var
  div $ React.createFactory :div
  img $ React.createFactory :img

= module.exports $ React.createClass $ {}
  :displayName :app-topic

  :propTypes $ {}
    :topic $ React.PropTypes.instanceOf Immutable.Map
    :onClick React.PropTypes.func.isRequired

  :onClick $ \ ()
    this.props.onClick

  :styleRoot $ \ ()
    {} (:display :flex) (:flexDirection :row)
      :marginBottom 5
      :cursor :pointer
      :backgroundColor $ ... (color) (hsl 0 0 100 0.9) (hslString)

  :styleText $ \ ()
    {} (:flex 1) (:marginLeft 10)

  :render $ \ ()
    div ({} (:className :app-topic) (:onClick this.onClick) (:style (this.styleRoot)))
      Member $ {}
        :member $ this.props.topic.get :userRef
      div ({} (:className :topic-text) (:style (this.styleText)))
        this.props.topic.get :text
