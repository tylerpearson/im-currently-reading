class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :amazon_asin
      t.string :image_url

      t.timestamps
    end
  end
end
