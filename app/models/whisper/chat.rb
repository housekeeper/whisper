module Whisper
  class Chat < ActiveRecord::Base

    attr_accessible :user_id, :from, :to, :message, :sent_at
    belongs_to :user, :class_name => Whisper.user_class.to_s

    scope :today_for_user, lambda { |user_id|
      where(:user_id => user_id).
      where(:sent_at => Time.now.midnight..Time.now.midnight+1.day)

    }

    def self.create_row(user_id, from, to, message, sent_at)
      Chat.create(user_id: user_id,
                  from:    from,
                  to:      to,
                  message: message,
                  sent_at: sent_at)
    end

  end
end