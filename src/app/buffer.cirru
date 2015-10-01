
var
  React $ require :react
  color $ require :color
  view $ require :../frontend/view
  Immutable $ require :immutable

var
  Member $ React.createFactory $ require :./member
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-buffer

  :propTypes $ {}
    :buffer $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired

  :styleRoot $ \ ()
    {} (:display :flex) (:flexDirection :row)
      :backgroundColor $ ... (color) (hsl 0 100 100 0.9) (hslString)
      :marginBottom 5

  :styleText $ \ ()
    {} (:flex 1) (:marginLeft 10)
      :maxHeight :200px

  :render $ \ ()
    var buffer this.props.buffer

    div ({} (:style $ this.styleRoot))
      Member $ {} (:member $ buffer.get :userRef) (:showName false)
      div ({} (:style $ this.styleText))
        buffer.get :text
