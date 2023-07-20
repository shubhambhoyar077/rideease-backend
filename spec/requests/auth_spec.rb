require 'swagger_helper'

RSpec.describe Users::SessionsController, type: :request do
  path '/users/sign_in' do
    post 'User Sign In' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user:{
          email: { type: :string },
          password: { type: :string }
        }},
        required: %w[email password]
      }

      response '200', 'Logged in successfully' do
        schema type: :object,
               properties: {
                 status: {
                   type: :object,
                   properties: {
                     code: { type: :integer },
                     message: { type: :string }
                   },
                   required: %w[code message]
                 },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     email: { type: :string },
                   },
                   required: %w[id name email]
                 }
               },
               required: %w[status data]

        run_test! do
          @user = User.create!(full_name: 'test', email: 'test@example.com', password: 'password')
          @user.confirm
      
          post '/users/sign_in', params: { user: { email: 'test@example.com', password: 'password' } }


          expect(response).to have_http_status(:ok)

          json_response = JSON.parse(response.body)
          expect(json_response).to include('status')
          expect(json_response['status']).to include('code', 'message')
          expect(json_response['status']['data']).to include('id', 'name', 'email')
        end
      end

      response '401', "Couldn't find an active session" do
        schema type: :object,
               properties: {
                 status: { type: :integer },
                 message: { type: :string }
               },
               required: %w[status message]

        run_test! do
          # Make a request to sign in without valid credentials
          post '/users/sign_in', params: { user: { email: 'invalid@example.com', password: 'invalidpassword' } }

          # Assert the response status code
          expect(response).to have_http_status(:unauthorized)

          # Assert the response body against the defined schema
          json_response = JSON.parse(response.body)
          expect(json_response).to include('status', 'message')
        end
      end
    end
  end

  # let(:Authorization) { "bearer_auth #{access_token}" }
    path '/users/sign_out' do
      delete 'User Sign Out' do
        tags 'Users'
        produces 'application/json'
        security [bearer_auth: []]
  
        response '200', 'Logged out successfully' do
          schema type: :object,
                 properties: {
                   status: { type: :integer },
                   message: { type: :string }
                 },
                 required: %w[status message]
  
          run_test! do
            # Create a sample user for testing
            @user = User.create!(full_name: 'John Doe', email: 'john@example.com', password: 'password', role: 'user')
            @user.config
  
            # Authenticate the user and get the bearer token
            post '/users/sign_in', params: { user: { email: 'john@example.com', password: 'password' } }
            auth_token = response.headers['Authorization']
  
            # Make a request to sign out with the bearer token in the Authorization header
            delete '/users/sign_out', headers: { 'Authorization' => auth_token }
  
            # Assert the response status code
            expect(response).to have_http_status(:ok)
  
            # Assert the response body against the defined schema
            json_response = JSON.parse(response.body)
            expect(json_response).to include('status', 'message')
          end
        end
      end
    end
  
  
end