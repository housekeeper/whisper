Whisper::Engine.routes.draw do

  resources :chats

  post 'pusher/auth'
  match 'chats/send_message' => 'chats#send_message'

end
