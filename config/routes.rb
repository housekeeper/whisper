Whisper::Engine.routes.draw do
  
  root :to => "chat#send_message"
  
  get "chat/send_message"

end
