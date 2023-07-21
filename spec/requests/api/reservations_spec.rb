require 'swagger_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Api::Reservations', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    @service = Service.create(name: "test car", image: "test.jpg")
    @user.confirm
    @reservation = Reservation.create(city: "test city", date: "2020-02-02", user: @user, service: @service)
  end

  describe 'GET /index' do

    path '/api/reservations' do

      get 'get a reserve car as per current user' do
        tags 'Reservation'
        produces 'application/json'
        security [bearer_auth: []]
  
        response '200', 'cars list' do
          before do
            sign_in @user
          end
          include Devise::JWT::TestHelpers
          let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first }
          let(:Authorization) { "Bearer #{jwt_token}" }
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.body).to include('test city') 
            expect(response.body).to include('2020-02-02') 
          end
        end
      end
    end
  end

  describe 'POST /create' do
    path '/api/reservations' do
      post 'Reserve car for current user' do
        tags 'Reservation'
        consumes 'application/json'
        produces 'application/json'
        security [bearer_auth: []]
        parameter name: :reservations, in: :body, schema: {
          type: :object,
          properties: {
            reservations: {
              type: :object,
              properties: {
                city: { type: :string },
                date: { type: :string },
                service_id: { type: :number },
              },
              required: ['city', 'date', 'service_id']
            }
          },
          required: ['reservations']
        }
  
        response '200', 'Reservation created' do
          before do
            sign_in @user
          end
          include Devise::JWT::TestHelpers
          let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first }
          let(:Authorization) { "Bearer #{jwt_token}" }
          let(:reservations) { { "reservations": { "city": "created city", "date": "2021-01-01", "service_id": @service.id } } }
          
  
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.body).to include('Reservation created sucessfully')
          end
        end
      end
    end
  end


  describe 'DELETE /destory' do

    path '/api/reservations/{id}' do

      delete 'Delete a Reservation' do
        tags 'Reservation'
        consumes 'application/json'
        produces 'application/json'
        security [bearer_auth: []]
        parameter name: :id, in: :path, type: :string
  
        response '204', 'delete reservation' do
          before do
            sign_in @user
          end
          include Devise::JWT::TestHelpers
          let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first }
          let(:Authorization) { "Bearer #{jwt_token}" }
          
          let(:id) {@reservation.id}
          run_test!
        end
      end
    end
  end
end
