class CreateWhisperChats < ActiveRecord::Migration
  def change
    create_table :whisper_chats do |t|
      t.string   :from
      t.string   :to
      t.string   :message
      t.datetime :sent_at
    end

    add_index :whisper_chats, :from
    add_index :whisper_chats, :to

  end
end
