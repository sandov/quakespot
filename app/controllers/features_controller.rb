class FeaturesController < ApplicationController
  def index

    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, 10).to_i
    mag_type_string = params.fetch(:mag_type, "")

    offset = (page - 1) * per_page;

    unless mag_type_string.present?     # gets executed if mag_type_string is empty string
      records = Feature.limit(per_page).offset(offset)
      total = records.except(:offset, :limit, :order).count
      records_formatted = format_for_view(records)
      records_formatted = format_for_view(records, page, per_page, total)
      render json: records_formatted
      return
    end

    # if mag_type_string is not empty:

    mag_type_arr = mag_type_string.split(",")

    conditions = mag_type_arr.map { |mag_type| {mag_type: mag_type}}

    queries = conditions.map { |condition| Feature.where(condition) }
    records = queries.reduce(:or).limit(per_page).offset(offset)

    total = records.except(:offset, :limit, :order).count

    records_formatted = format_for_view(records, page, per_page, total)
    render json: records_formatted

    # TODO: refactor

  end

  private

  def format_for_view(raw_features, page, per_page, total)
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
        "current_page" => page,
        "total" => total,
        "per_page" => per_page
      }
    }

    #TODO: real pagination

    return parent_hash

  end
end


