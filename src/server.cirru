
var
  database $ require :./backend/database
  differ $ require :./backend/differ
  expand $ require :./backend/expand
  websocket $ require :./backend/websocket
  Pipeline $ require :./util/pipeline

websocket.setup $ {}
  :port 3000

differ.setup $ {}
  :expand expand

Pipeline.forward websocket.out database.in
Pipeline.forward database.out differ.in
Pipeline.forward differ.out websocket.in

Pipeline.for websocket.out $ \ (data)
  console.log :websocket.out data

Pipeline.for differ.out $ \ (data)
  console.log :differ.out data
