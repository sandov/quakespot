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

    filtered_features = features.map do |item|
        {
          "id" => item["id"],
          "properties" => {
            "mag" => item["properties"]["mag"],
            "place" => item["properties"]["place"],
            "time" => item["properties"]["time"],
            "url" => item["properties"]["url"],
            "tsunami" => item["properties"]["tsunami"],
            "magType" => item["properties"]["magType"],
            "title" => item["properties"]["title"]
          },
          "geometry" => {
            "coordinates" => item["geometry"]["coordinates"][0..1]
          }
        }
      end

    puts(filtered_features)

end
