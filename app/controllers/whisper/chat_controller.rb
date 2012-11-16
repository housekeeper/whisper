require_dependency "whisper/application_controller"

module Whisper
  class ChatController < ApplicationController
    def index

    end

    def send_message
      if params[:message].present? && whisper_user
        # insert chat row into db
        from    = whisper_user.username
        to      = "*"
        message = params[:message]
        sent_at = Time.now

        # whisper
        # ex: /housekeeping so you spin this coming friday?
        if message.start_with?("/")
          to = message.split(' ')[0][1..-1]
          to_user = User.find_by_username to
          message = message.split(' ')[1..-1].join(' ')

          if to_user.nil?
            #send message to oneself saying username does not exist
            Pusher['private-user-channel-' + whisper_user.id.to_s].trigger('send-user-message', {:message => "#{to} does not exist.", :from => from, :to => from})
            head :unprocessable_entity
          else
            #whisper
            Pusher['private-user-channel-' + to_user.id.to_s].trigger('send-user-message', {:message => message, :from => from, :to => to})
            head :ok
          end
        else
          # broadcast
          Pusher['presence-channel'].trigger('send-message', {:message => message, :from => from})
          head :ok
        end
        Chat.create_row(from, to, message, sent_at)
      end
      # head :ok
    end
  end
end
