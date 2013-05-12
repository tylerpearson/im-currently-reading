class Message < ActiveRecord::Base
  attr_accessible :book_id, :message

  belongs_to :book

  extend FriendlyId
  friendly_id :custom_slug, use: :slugged

  def custom_slug
    "#{self.book.author_name}-#{self.book.title}"
  end

end
