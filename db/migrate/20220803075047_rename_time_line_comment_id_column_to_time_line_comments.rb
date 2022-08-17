# frozen_string_literal: true

class RenameTimeLineCommentIdColumnToTimeLineComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :time_line_comments, :time_line_comment_id, :time_line_id
  end
end
