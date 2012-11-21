module Whisper
  module ApplicationHelper

    def whisper_for(user, opts = {})
      username = user.username
      userid   = user.id
      render :partial => "whisper/chat/popin", :locals => {:userid => userid, :username => username, :opts => opts}
    end

  end
end
