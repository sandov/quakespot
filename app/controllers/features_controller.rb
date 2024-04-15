class FeaturesController < ApplicationController
  def index
    @features = Feature.all
    features_formatted = format_for_view(@features)
    render json: features_formatted
  end

  private

  def format_for_view(raw_features)
    hash_array_formatted = raw_features.map do |item|
      {
        "id" => item["id"],
        "type" => "feature",
        "attributes" => {
          "external_id" => item["extern_id"],
          "magnitude" => item["magnitude"],
          "place"  => item["place"],
          "time" => item["time"],
          "tsunami" => item["tsunami"],
          "mag_type" => item["mag_type"],
          "title" => item["title"],
          "coordinates" => {
            "longitude" => item["coord_long"],
            "latitude" => item["coord_lat"],
          },
          "links" => {
            "external_url" => item["external_url"]
          }
        }
      }
    end

    parent_hash = {
      "data": hash_array_formatted,
      "pagination" => {
        "current_page" => 1,
        "total" => 1,
        "per_page" => 1
      }
    }

    #TODO: real pagination

    return parent_hash

  end
end


