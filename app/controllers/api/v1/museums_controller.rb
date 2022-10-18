require "json"
require "open-uri"

class Api::V1::MuseumsController < ApplicationController
  def index
    @museums = Museum.all
    render json: @museums
  end

  def search
    case
    when params["name"]
      render json: Museum.find_by_param(:name, params["name"].titleize)
    when params["postcode"]
      render json: Museum.find_by_param(:postcode, params["postcode"])
    when params["lat"] && params["long"]
      relevant_results = get_results_from_api(params["lat"], params["long"])
      final_results = format_results(relevant_results)
      render json: final_results
    end
  end

  private

  def get_results_from_api(latitude, longitude)
    # Call mapbox api to search for lat and long
    api_key = ENV["API_KEY"]
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{longitude},#{latitude}&limit=10&access_token=#{api_key}"
    search_results = JSON.parse(URI.open(url).read)

    # Mapbox retrieves results which contain "museum" in their name or as a category,
    # so we select only results which are categorised as "poi" to avoid results like "Museumkwartier" (which is a district in Amsterdam)
    relevant_results = search_results["features"].select { |result| result["place_type"].include?("poi") }
    # and where "museum" is the name of the category in order to avoid results like "Museum Store Products" (which is a business categorised as "poi")
    relevant_results.select { |result| result["properties"]["category"].split(", ").include?("museum") }
  end

  def format_results(results)
    # Initiate a hash to show results as "postcode:" [museums]
    formatted_results = {}
    # For each result :
    results.each do |result|

      # Get the name of the museum in "text"
      museum_name = result["text"]

      # Get its postcode in "context", which is an array of hashes
      # The postcode is not always at the same position in the array so we need to find the hash with an id formatted as "postcode.21630700"
      # The postcode is then at the "text" key of that hash
      museum_postcode = result["context"].find { |result| result["id"].split(".").first == "postcode" }["text"]

      # push these results to the hash
      if formatted_results.keys.include?(museum_postcode)
        formatted_results[museum_postcode].push(museum_name)
      else
        formatted_results[museum_postcode] = [museum_name]
      end
    end
    formatted_results
  end
end
