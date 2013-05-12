class AddInfoToBooks < ActiveRecord::Migration
  def change
    add_column :books, :author_name, :string
    add_column :books, :amazon_url, :text
  end
end
