# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  respond_to :json

  private

  def respond_with(resource, options={})
    if resource.is_a?(Hash) && resource.empty?
      render json: {
        status: {code: 200, message: "Password reset Email Resend successfully"}
      }, status: :ok
    elsif request.method == "POST" && resource && resource.jti.nil?
      render json: {
        status: {code: 200, message: "User does not exist",
        data: resource}
      }, status: :ok
    elsif request.method == "PUT" && resource.errors.empty?
      render json: {
        status: { code: 200, message: "Password change successfully"}
      }, status: :ok
    else
      render json: {
        status: {code: 422, message: "Error. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
