
var
  React $ require :react

require :./frontend/websocket

var
  Page $ React.createFactory $ require :./app/page

React.render (Page) document.body
