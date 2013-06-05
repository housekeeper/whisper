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
          to_user = User.where("lower(username) = ? OR username = ?", to.downcase, to).first
          message = message.split(' ')[1..-1].join(' ')

          if to.eql?("team")
            # team
            if !whisper_user.team.nil?
              Pusher['private-team-channel-' + whisper_user.team.id.to_s].trigger('send-team-message', {:message => message, :from => from, :to => whisper_user.team.name})
              head :ok
            else
              Pusher['private-team-channel-' + whisper_user.id.to_s].trigger('send-team-message', {:message => "join a team first!", :from => from, :to => from})
              head :unprocessable_entity
            end
          elsif to_user.nil?
            # user does not exist
            Pusher['private-user-channel-' + whisper_user.id.to_s].trigger('send-user-message', {:message => "#{to} does not exist", :from => from, :to => from})
            head :unprocessable_entity
          elsif to_user
            # whisper
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
    end
  end
end
