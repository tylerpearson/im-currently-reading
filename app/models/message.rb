class Message < ActiveRecord::Base
  attr_accessible :book_id, :message

  belongs_to :book

  extend FriendlyId
  friendly_id :custom_slug, use: :slugged

  def custom_slug
    "#{self.book.title.truncate(50, :separator => ' ')}-by-#{self.book.author_name}"
  end

end
