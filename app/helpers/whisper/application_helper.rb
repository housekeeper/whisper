module Whisper
  module ApplicationHelper

    def whisper_for(user, opts = {})
      render :partial => "whisper/chat/popin", :locals => {:current_user => user, :opts => opts}
    end

  end
end
