require 'test_helper'

module Whisper
  class ChatControllerTest < ActionController::TestCase
    test "should get send_message" do
      get :send_message
      assert_response :success
    end
  
  end
end
