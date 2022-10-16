class Api::V1::MuseumsController < ApplicationController
  def index
    @museums = Museum.all
    render json: @museums
  end

  def search
    render json: { message: "yay!"}
  end
end
