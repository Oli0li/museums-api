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
