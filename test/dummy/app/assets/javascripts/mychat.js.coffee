## Place all the behaviors and hooks related to the matching controller here.
## All this logic will automatically be available in application.js.
## You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

pusher = new Pusher("e77c8d27f667516177f3")
channel = pusher.subscribe("ror-channel")

channel.bind "send-message", (data) ->
  $(".chatboxcontent").append "<div class='chatboxmessage'><span class='chatboxmessagefrom'>" + data.username + ": </span><span class='chatboxmessagecontent'>" + data.message + "</span></div>"
  console.log "An event was triggered with message: " + data.message


pusher.connection.bind "state_change", ->
  console.log pusher.connection.state
