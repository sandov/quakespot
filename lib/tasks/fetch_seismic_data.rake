desc "Fetch data from USGS's Past 30 Days feed. Store it in db"
task fetch_seismic_data: :environment do
  require 'net/http'
  require 'json'

  api_url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'

  api_uri = URI(api_url)
  api_response = Net::HTTP.get_response(api_uri)

  unless api_response.is_a?(Net::HTTPSuccess)
      puts "Error: Failed to fetch seismic data. HTTP Status Code: #{api_response.code}"
      exit 1
  end

  data = JSON.parse(api_response.body)

  features = data["features"]

  # Generate a Hash with only the required fields, and the same
  # field names as our Model attributes, so that `filtered_features`
  # can be saved directly.
  # We remove the nesting from the response JSON/Hash, since
  # it doesn't make sense from a modelling standpoint
  # i.e. coordinates are simply attributes
  # No need for a nested geometry object/Hash. Flat Hash is better.
  filtered_features = features.map do |item|
  {
    "extern_id" => item["id"],
    "magnitude" => item["properties"]["mag"],
    "place" => item["properties"]["place"],
    "time" => item["properties"]["time"],
    "external_url" => item["properties"]["url"],
    "tsunami" => item["properties"]["tsunami"],
    "mag_type" => item["properties"]["magType"],
    "title" => item["properties"]["title"],
    "coord_long" => item["geometry"]["coordinates"][0],
    "coord_lat" => item["geometry"]["coordinates"][1]
  }
  end

  records_added = 0
  validation_errors = 0

  filtered_features.each do |hash|
    instance = Feature.new(hash)
    if instance.save
      records_added += 1
    else
      validation_errors += 1
    end
  end

  puts "#{records_added} records added succesfully"
  puts "#{validation_errors} validation errors (including uniqueness validation)"
    
end
