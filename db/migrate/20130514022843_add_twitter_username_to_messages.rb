class AddTwitterUsernameToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :twitter_username, :string
  end
end
