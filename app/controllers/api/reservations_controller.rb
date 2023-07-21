class Api::ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reservations = current_user.reservations.includes(:service)
    @reservation_data = @reservations.map do |reservation|
      { reservation:reservation, service: reservation.service }
    end

    render json: @reservation_data
  end

  def create
    # create reservation using POST method
    @reservation = current_user.reservations.new(reservations_param)
    if @reservation.save
      render json: {
        status: { code: 200, message: 'Reservation created sucessfully.' }
      }, status: :ok
    else
      render json: {
        status: 422,
        message: @reservation.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy

    head :no_content
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  private

  def reservations_param
    params.require(:reservations).permit(:city, :date, :service_id)
  end

  def current_user
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             ENV.fetch('DEVISE_JWT_SECRET_KEY', nil)).first
    User.find(jwt_payload['sub'])
  end
end
