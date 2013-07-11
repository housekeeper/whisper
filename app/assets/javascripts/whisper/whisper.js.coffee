//= require_tree .

# Pusher.channel_auth_endpoint = '/whisper/pusher/auth';
# pusher = new Pusher("e77c8d27f667516177f3", { encrypted: true })
# presenceChannel = pusher.subscribe("presence-channel")

# presenceChannel.bind "send-message", (data) ->
#   $(".chatbox:not(#chatbox_team)").children(".chatboxcontent").append "<div class='chatboxmessage'><span class='chatboxmessagefrom'>" + data.from + ": </span><span class='chatboxmessagecontent'>" + data.message + "</span></div>"
#   console.log "An event was triggered with message: " + data.message

# ## debug
# pusher.connection.bind "state_change", ->
#   console.log pusher.connection.state
