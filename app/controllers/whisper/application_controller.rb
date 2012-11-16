module Whisper
  class ApplicationController < ActionController::Base
    def whisper_user
      current_user
    end
    helper_method :whisper_user
  end
end
