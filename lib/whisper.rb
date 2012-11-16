require "whisper/engine"

module Whisper
  mattr_accessor :user_class

  class << self
    def user_class
      if @@user_class.is_a?(Class)
        raise "Whisper.user_class cannot be a class. Please use a string instead.\n\n"
      elsif @@user_class.is_a?(String)
        @@user_class.constantize
      end
    end
  end

end
