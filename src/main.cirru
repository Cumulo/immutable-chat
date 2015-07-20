
var
  session $ require :./frontend/session
  store $ require :./frontend/store
  websocket $ require :./frontend/websocket
  view $ require :./frontend/view
  Pipeline $ require :./util/pipeline

websocket.setup $ {} (:port 3000)

Pipeline.forward websocket.out store.in
Pipeline.for store.out $ \ (data)
  Pipeline.send view $ {}
    :target :store
    :data data
Pipeline.for session.out $ \ (data)
  Pipeline.send view $ {}
    :target :session
    :data data

Pipeline.forward view.out websocket.in

