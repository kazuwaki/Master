# frozen_string_literal: true

class ChangeDataBodyToPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :body, :text
  end
end
