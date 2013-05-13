require 'json'

class Book < ActiveRecord::Base
  attr_accessible :amazon_asin, :description, :image_url, :title, :amazon_url, :medium_image_url

  validates :title, :presence => true

  validates :amazon_asin, :uniqueness => true, :presence => true

  has_one :message

  before_validation :add_amazon_info


  def add_amazon_info

    Amazon::Ecs.options = {
      :associate_tag     => ENV["AWS_ASSOCIATE_TAG"],
      :AWS_access_key_id => ENV["AWS_ACCESS_KEY"],
      :AWS_secret_key    => ENV["AWS_SECRET_KEY"]
    }

    res = Amazon::Ecs.item_lookup(self.amazon_asin, {:response_group => 'Medium', :sort => 'relevancerank'})

    if res.is_valid_request?
      puts "It's a valid request"
      @info = to_hash(res.items)[0]
      puts @info.to_json
    end

    if res.has_error?
      puts "There is an error"
      puts res.error
    end

    self.title            = @info["ItemAttributes"]["Title"]
    self.amazon_url       = @info["DetailPageURL"]
    self.image_url        = @info["LargeImage"]["URL"]
    self.medium_image_url = @info["MediumImage"]["URL"]

    if @info["EditorialReviews"]["EditorialReview"].kind_of?(Array)
      self.description = @info["EditorialReviews"]["EditorialReview"][0]["Content"]
    else
      self.description = @info["EditorialReviews"]["EditorialReview"]["Content"]
    end

    if @info["ItemAttributes"]["Author"].kind_of?(Array)
      self.author_name = @info["ItemAttributes"]["Author"].join(", ")
    else
      self.author_name = @info["ItemAttributes"]["Author"]
    end

  end

  # convert array to hash
  def to_hash(array)
    array.map do |item|
      Hash.from_xml("<root>#{item.elem.inner_html}</root>")['root']
    end
  end

end
