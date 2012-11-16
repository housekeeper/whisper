module Whisper
  # Using https://github.com/pusher/pusher-gem      
  class PusherController < ApplicationController
    protect_from_forgery :except => :auth # stop rails CSRF protection for this action

    def auth
      if whisper_user
        response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
          :user_id => whisper_user.id, # => required
          :user_info => {              # => optional
            :name => current_user.name,
            :email => current_user.email,
            :username => current_user.username
          }
        })
        render :json => response
      else
        render :text => "Forbidden", :status => '403'
      end
    end
  end
end