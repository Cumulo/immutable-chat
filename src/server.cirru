
var
  database $ require :./backend/database
  differ $ require :./backend/differ
  expand $ require :./backend/expand
  websocket $ require :./backend/websocket
  Pipeline $ require :./util/pipeline

websocket.setup $ {}
  :port 3000

Pipeline.forward websocket.out database.in
Pipeline.forward database.out differ.in
Pipeline.forward differ.out websocket.in

Pipeline.for differ.out $ \ (data)
  console.log :differ.out data
