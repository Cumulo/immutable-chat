
var
  store $ require :./frontend/store
  websocket $ require :./frontend/websocket
  view $ require :./frontend/view
  page $ require :./app/page
  Pipeline $ require :cumulo-pipeline

require :./app/page
require :origami-ui
require :react-origami-tabs/src/tabs.css

websocket.setup $ {} (:port 3000)

websocket.out.forward store.in
view.out.forward websocket.in

store.out.for $ \ (data)
  page.in.send $ {}
    :target :store
    :data data

store.out.for $ \ (data)
  console.info $ data.toJS
