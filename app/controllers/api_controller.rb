class ApiController < ApplicationController

  def books

    puts ENV["AWS_SECRET_KEY"]

    Amazon::Ecs.options = {
      :associate_tag     => "1336-2615-6166",
      :AWS_access_key_id => "/323HRCmUnNsbpqZ8YeANeiXanx59D0WObhKkxSg",
      :AWS_secret_key    => "AKIAJKAHV2TBQBHHOMIA"
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
