# frozen_string_literal: true

class CreateAlcohols < ActiveRecord::Migration[6.1]
  def change
    create_table :alcohols do |t|

      t.string :name, null: false
      t.timestamps
    end
  end
end
