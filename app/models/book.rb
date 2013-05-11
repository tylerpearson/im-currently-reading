require 'json'

class Book < ActiveRecord::Base
  attr_accessible :amazon_asin, :description, :image_url, :title, :comment

  validates :title, :presence => true

  before_create :get_amazon_info, :puts_info


  private

  def get_amazon_info

    Amazon::Ecs.options = {
      :associate_tag     => ENV["AWS_ASSOCIATE_TAG"],
      :AWS_access_key_id => ENV["AWS_ACCESS_KEY"],
      :AWS_secret_key    => ENV["AWS_SECRET_KEY"]
    }

    res = Amazon::Ecs.item_search(self.title, {:response_group => 'Small', :sort => 'relevancerank'})

    if res.is_valid_request?
      puts "It's a valid request"
      puts Hash.from_xml(res.items)
      puts res.items.to_json
      puts res.to_json
    end

    if res.has_error?
      puts "There is an error"
      puts res.error
    end


  end

  def puts_info
    puts "Title: " + self.title
  end

end
