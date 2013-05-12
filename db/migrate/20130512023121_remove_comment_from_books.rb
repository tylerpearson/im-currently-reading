class RemoveCommentFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :comment
  end

  def down
    add_column :books, :comment, :text
  end
end
