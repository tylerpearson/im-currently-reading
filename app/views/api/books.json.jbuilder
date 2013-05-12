json.key_format! :camelize => :lower
json.array! @results do |result|
  json.asin_ID result["ASIN"]
  json.title result["ItemAttributes"]["Title"]
  json.author result["ItemAttributes"]["Author"]
  json.amazon_url result["DetailPageURL"]
  json.description result["EditorialReviews"]["EditorialReview"]
  json.binding result["ItemAttributes"]["Binding"]

  json.images do |json|
    json.small result["SmallImage"]
    json.medium result["MediumImage"]
    json.large result["LargeImage"]
  end

end