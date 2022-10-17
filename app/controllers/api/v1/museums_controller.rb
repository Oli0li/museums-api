class Api::V1::MuseumsController < ApplicationController
  def index
    @museums = Museum.all
    render json: @museums
  end

  def search
    case
    when params["name"]
      render json: Museum.find_by_param(:name, params["name"])
    when params["postcode"]
      render json: Museum.find_by_param(:postcode, params["postcode"])
    when params["lat"] && params["long"]
      # call mapbox api to search for lat and long
      "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=13.437641,52.494857&limit=10&access_token="
      # select only results where properties[:category] includes "museum"
      # for each result :
      # get the name of the museum in "text"
      # get its postcode in context[0]["text"]
      # create an instance of Museum
      # create a hash to show results as "postcode:" [museums]
      render json: { message: "yay!" }
    end
  end
end
