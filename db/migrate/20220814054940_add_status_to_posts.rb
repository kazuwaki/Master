# frozen_string_literal: true

class AddStatusToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :status, :integer, null: false, default: 0
  end
end
