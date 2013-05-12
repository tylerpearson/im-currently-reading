class Message < ActiveRecord::Base
  attr_accessible :book_id, :message

  belongs_to :book

end
