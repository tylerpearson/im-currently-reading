require 'json'

class Book < ActiveRecord::Base
  attr_accessible :amazon_asin, :description, :image_url, :title, :comment

  validates :title, :presence => true

  #before_create :get_amazon_info


  private

  def get_amazon_info

    Amazon::Ecs.options = {
      :associate_tag     => ENV["AWS_ASSOCIATE_TAG"],
      :AWS_access_key_id => ENV["AWS_ACCESS_KEY"],
      :AWS_secret_key    => ENV["AWS_SECRET_KEY"]
    }

    res = Amazon::Ecs.item_search(self.title, {:response_group => 'Medium', :sort => 'relevancerank'})

    if res.is_valid_request?
      puts "It's a valid request"
      puts to_hash(res.items).to_json
    end

    if res.has_error?
      puts "There is an error"
      puts res.error
    end

  end


  #
  # Converts given array to a Hash
  #
  def to_hash(array)
    array.map do |item|
      Hash.from_xml("<root>#{item.elem.inner_html}</root>")['root']
    end
  end

end
