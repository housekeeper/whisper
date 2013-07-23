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

        case 

        # TEAM
        when params[:from].eql?("team")

          # TEAM_WHISPER
          if params[:message].start_with?("/")
            to_user = User.where("lower(username) = ?", to).first
            if to_user
              # OK
              @channel = "team_whisper"
              @to = to_user.id
            else
              # KO
              @channel = "team_self"
            end

          # TEAMCAST
          else

            @channel = "team"
            if whisper_user.team
              # OK
              @to = whisper_user.team.id
            else
              # KO
              @channel = "team_self"
            end
          end

        # WHISPER
        when params[:message].start_with?("/")
          to_user = User.where("lower(username) = ?", to).first
          if to_user
            # OK
            @channel = "whisper"
            @to = to_user.id
          else
            # KO
            @channel = "whisper_self"
          end

        # BROADCAST
        else
          # OK
          @channel = "broadcast"

        end             

        respond_to do |format|
          format.js
        end
      end
    end

  end
end
