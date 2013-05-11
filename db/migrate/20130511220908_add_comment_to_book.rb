class AddCommentToBook < ActiveRecord::Migration
  def change
    add_column :books, :comment, :text
  end
end
