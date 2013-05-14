class Message < ActiveRecord::Base
  attr_accessible :book_id, :message, :twitter_username

  belongs_to :book

  extend FriendlyId
  friendly_id :custom_slug, use: :slugged

  before_create :clear_username

  def custom_slug
    "#{self.book.title.truncate(50, :separator => ' ')}-by-#{self.book.author_name}"
  end

  def clear_username
    self.twitter_username = self.twitter_username.gsub(/@/,'')
  end

end
