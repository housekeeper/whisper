Rails.application.routes.draw do

  root :to => "simulate#index"

  get "simulate/index"
  post "simulate/send_message"

  match '/send_message' => 'simulate#send_message'

  mount Whisper::Engine => "/whisper"
end
