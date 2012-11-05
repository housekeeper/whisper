module Whisper
  class Chat < ActiveRecord::Base

    attr_accessor :username
    belongs_to :user, :class_name => "User"

    before_save :set_user

    private

    def set_user
      self.user = User.find_by_username username
    end

  end
end