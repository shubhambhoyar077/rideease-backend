class Api::ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reservations = current_user.reservations.includes(:service)
    @reservation_data = @reservations.map do |reservation|
      { reservation:, service: reservation.service }
    end

    render json: @reservation_data
  end

  def create
    # create reservation using POST method
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy

    head :no_content
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  private

  def current_user
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             ENV.fetch('DEVISE_JWT_SECRET_KEY', nil)).first
    User.find(jwt_payload['sub'])
  end
end
