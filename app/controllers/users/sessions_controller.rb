class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _options = {})
    if current_user
      render json: {
        status: { code: 200, message: 'Logged in sucessfully.',
                  data: current_user }
      }, status: :ok
    else
      render json: {
        status: 401,
        message: 'Please confirm your email address before continuing.'
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             ENV.fetch('DEVISE_JWT_SECRET_KEY', nil)).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: {
        status: 200,
        message: 'logged out successfully'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
