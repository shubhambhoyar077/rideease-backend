require 'rails_helper'

RSpec.describe 'Api::Reservations', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    @user.confirm
    sign_in @user
  end

  describe 'GET /index' do
    context 'get reservation from current user' do
      before do
        get '/cars', headers: { 'Authorization' => "Bearer #{user.auth_token}" }
      end

      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'returns the list of cars' do
        # Add your expectations for the response body here
      end
    end
  end
end
