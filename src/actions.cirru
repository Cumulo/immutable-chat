
var
  emitter $ require :./util/emitter
  stream $ require :./util/stream

var
  ({}~ createEmitter triggerEmitter) emitter
  ({}~ createStream) stream

var actionEvents $ createEmitter

= exports.stream $ createStream actionEvents
= exports.dispatch $ \ (action)
  triggerEmitter actionEvents action
