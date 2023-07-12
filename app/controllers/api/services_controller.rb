class Api::ServicesController < ApplicationController
  def index
    # For cars list: main page
    render json: Service.all
  end

  def show
    # For car details page
  end

  def create
    # For create Cars using post method.
  end
end
