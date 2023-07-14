# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  respond_to :json

  private

  def respond_with(resource, options={})
    if resource.is_a?(Hash) && resource.empty?
      render json: {
        status: {code: 200, message: "Email Resend successfully"}
      }, status: :ok
    elsif resource && resource.jti.nil?
      render json: {
        status: {code: 200, message: "User does not exist",
        data: resource}
      }, status: :ok
    else
      render json: {
        status: {code: 200, message: "User already exist",
        data: resource}
      }, status: :ok
    end
  end

    def respond_with_navigational(resource, options={})
      if resource.errors.empty?
        render json: {
          status: {code: 200, message: "User conform successfully",
          data: resource}
        }, status: :ok
      else
        render json: {
          status: {code: 422, message: "Error please try again. #{resource.errors.full_messages.to_sentence}"}
        }, status: :unprocessable_entity
      end
    end
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
