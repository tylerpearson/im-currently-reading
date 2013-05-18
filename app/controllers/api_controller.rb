class ApiController < ApplicationController

  def books

    puts ENV["AWS_SECRET_KEY"]

    Amazon::Ecs.options = {
      :associate_tag     => ENV["AWS_ASSOCIATE_TAG"],
      :AWS_access_key_id => ENV["AWS_ACCESS_KEY"],
      :AWS_secret_key    => ENV["AWS_SECRET_KEY"]
    }

    res = Amazon::Ecs.item_search(params[:title], {:response_group => 'Medium', :sort => 'relevancerank'})

    if res.is_valid_request?
      @results = to_hash(res.items)
    else
      puts res
    end

    @title = @results.as_json

    respond_to do |format|
      format.html
      format.json
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
