class RenameUserIdColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :user_id, :customer_id
  end
end
