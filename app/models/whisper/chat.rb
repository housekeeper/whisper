module Whisper
  class Chat < ActiveRecord::Base

    attr_accessible :from, :to, :message, :sent_at
    belongs_to :user, :class_name => Whisper.user_class.to_s

    before_save :set_user

    scope :today_for_user, lambda { |user_id|
      where(:user_id => user_id).
      where(:sent_at => Time.now.midnight..Time.now.midnight+1.day)

    }

    def self.create_row(from, to, message, sent_at)
      Chat.create(:from    => from,
                  :to      => to,
                  :message => message,
                  :sent_at => sent_at)
    end

    private

    def set_user
      self.user = Whisper.user_class.to_s.constantize.find_by_username from
    end

  end
end