class AddMediumImageUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :medium_image_url, :string
  end
end
