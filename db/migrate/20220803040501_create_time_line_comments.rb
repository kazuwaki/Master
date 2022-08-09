class CreateTimeLineComments < ActiveRecord::Migration[6.1]
  def change
    create_table :time_line_comments do |t|
      
      t.integer :customer_id
      t.integer :time_line_comment_id
      t.string :comment
      t.timestamps
    end
  end
end
