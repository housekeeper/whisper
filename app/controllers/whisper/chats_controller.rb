require_dependency "whisper/application_controller"

module Whisper
  class ChatsController < ApplicationController
    def index

    end

    def send_message
      if params[:message].present? && params[:from].present?

        to      = params[:message].start_with?("/") ? params[:message].split(' ')[0][1..-1].downcase : "*"
        message = params[:message].start_with?("/") ? params[:message].split(' ')[1..-1].join(' ') : params[:message]
        from    = whisper_user.username.downcase
        sent_at = Time.now
        user_id = whisper_user.id
        @chat   = Chat.create_row(user_id, from, to, message, sent_at)

        respond_to do |format|
          # whisper
          if params[:message].start_with?("/")
            to_user = User.where("lower(username) = ?", to).first

            if to_user
              # whisper
              @channel = "whisper"
              @to = to_user.id
              format.js
            else
              # user does not exist
              @channel = "self"
              format.js
            end

          # team
          elsif params[:from].eql?("team")
            if whisper_user.team
              @channel = "team"
              @team = whisper_user.team.id
              format.js
            else
              @channel = "self"
              format.js
            end

          # broadcast
          else
            @channel = "broadcast"
            format.js
          end
        end

      end
    end

  end
end
