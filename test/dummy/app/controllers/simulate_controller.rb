class SimulateController < ApplicationController

  def index
    
  end

  def send_message
    if params[:message].present?
      username = "username"
      Pusher['ror-channel'].trigger('send-message', {:message => params[:message], :username => username})
    end
    head :ok
  end
end
