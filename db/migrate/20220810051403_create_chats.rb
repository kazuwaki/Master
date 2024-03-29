# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :customer_id
      t.integer :room_id
      t.string :message

      t.timestamps
    end
  end
end
