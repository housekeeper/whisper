require_dependency "whisper/application_controller"

module Whisper
  class ChatController < ApplicationController
    def index

    end

    def create
      @message = Chat.create!(params[:message])
      PrivatePub.publish_to("/chats/new", message: @message)
    end

    def send_message
      if params[:message].present? && whisper_user && params[:team].present?

        # insert chat row into db
        from    = whisper_user.username.downcase
        to      = "*"
        message = params[:message]
        sent_at = Time.now


        # whisper
        # ex: /carlb so you spin this coming friday?
        if message.start_with?("/")
          to = message.split(' ')[0][1..-1].downcase
          to_user = User.where("lower(username) = ?", to).first
          message = message.split(' ')[1..-1].join(' ')

          if to_user.nil?
            # user does not exist
            Pusher['private-user-channel-' + whisper_user.id.to_s].trigger('send-user-message', {:message => "#{to} does not exist", :from => from, :to => from})
            head :unprocessable_entity
          elsif to_user
            # whisper
            Pusher['private-user-channel-' + to_user.id.to_s].trigger('send-user-message', {:message => message, :from => from, :to => to})
            head :ok
          end

        # team
        elsif params[:team].eql?("true")
          if !whisper_user.team.nil?
            Pusher['private-team-channel-' + whisper_user.team.id.to_s].trigger('send-team-message', {:message => message, :from => from, :to => whisper_user.team.name})
            head :ok
          else
            Pusher['private-user-channel-' + whisper_user.id.to_s].trigger('send-user-message', {:message => "join a team first!", :from => from, :to => from})
            head :unprocessable_entity
          end

        # broadcast
        else
          Pusher['presence-channel'].trigger('send-message', {:message => message, :from => from})
          head :ok
        end
        Chat.create_row(from, to, message, sent_at)
      end
    end
  end
end
