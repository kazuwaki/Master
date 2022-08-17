# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      
      t.references :customer, foreign_key: true
      t.references :follow, foreign_key: { to_table: :customers }
      t.index [:customer_id, :follow_id], unique: true
      t.timestamps
    end
  end
end
