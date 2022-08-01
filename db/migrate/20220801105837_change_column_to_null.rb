class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :posts, :customer_id, true
  end

  def down
    change_column_null :posts, :customer_id, false
  end
end
