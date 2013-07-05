Whisper::Engine.routes.draw do

  post 'pusher/auth'
  match 'chats/send_message' => 'chats#send_message'

end
