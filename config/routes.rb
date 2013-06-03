Whisper::Engine.routes.draw do

  post 'pusher/auth'
  match 'chat/send_message' => 'chat#send_message'

end
