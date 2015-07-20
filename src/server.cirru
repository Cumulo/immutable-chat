
var
  database $ require :./backend/database
  differ $ require :./backend/differ
  expand $ require :./backend/expand
  websocket $ require :./backend/websocket
  persistent $ require :./backend/persistent
  Pipeline $ require :./util/pipeline
  colors $ require :colors

websocket.setup $ {}
  :port 3000

differ.setup $ {}
  :expand expand

Pipeline.forward websocket.out database.in
Pipeline.forward database.out differ.in
Pipeline.forward differ.out websocket.in
Pipeline.forward database.out persistent.in

Pipeline.for websocket.out $ \ (data)
  console.log (colors.red :websocket.out) data

Pipeline.for differ.out $ \ (data)
  console.log (colors.red :differ.out) data
