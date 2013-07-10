Whisper::Engine.routes.draw do

  resources :chats

  post 'pusher/auth'
  match 'chat/send_message' => 'chat#send_message'

end
