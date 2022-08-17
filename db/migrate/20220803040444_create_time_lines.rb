# frozen_string_literal: true

class CreateTimeLines < ActiveRecord::Migration[6.1]
  def change
    create_table :time_lines do |t|
      
      t.integer :customer_id
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
