require 'swagger_helper'

RSpec.describe Users::SessionsController, type: :request do
  before do
    @user = User.create(email: 'test100@example.com', password: '123456')
    @user.confirm
  end
  path '/users' do
    post 'User Sign Up' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: {type: :string},
              email: { type: :string },
              password: { type: :string }
            },
            required: %w[email password]
          }
        },
        required: %w[user]
      }
      

      response '200', "Sign up successfully Please check your email" do
        let(:user) { { "user": { "name": "test", "email": "test@example.com", "password": "123456" } } }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response).to include('status')
          expect(json_response['status']).to include('code', 'message')
        end
      end
      

      response '422', "User couldn't be created successfully" do
        let(:user) { { "user": { "name": "test", "password": "123456" } } }

        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
          json_response = JSON.parse(response.body)
          expect(json_response).to include('status')
        end
      end
    end
  end


  path '/users/sign_in' do
    post 'User Sign In' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: %w[email password]
          }
        },
        required: %w[user]
      }
      

      response 200, 'Logged in successfully' do
        let(:user) { { "user": { "email": "test100@example.com", "password": "123456" } } }
      
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response).to include('status')
          expect(json_response['status']).to include('code', 'message')
          expect(json_response['status']['data']).to include('id', 'name', 'email')
        end
      end
      

      response '401', "Couldn't find an active session" do
        let(:user) { { "user": { "email": "test100@example.", "password": "123456" } } }

        run_test! do |response|
          post '/users/sign_in', params: user
          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to include('Invalid Email or password.')
        end
      end
    end
  end

  #   path '/users/sign_out' do
  #     delete 'User Sign Out' do
  #       tags 'Users'
  #       produces 'application/json'
  #       security [bearer_auth: []]
  
  #       response '200', 'Logged out successfully' do
  #         schema type: :object,
  #                properties: {
  #                  status: { type: :integer },
  #                  message: { type: :string }
  #                },
  #                required: %w[status message]
  
  #         run_test! do
  #           @user = User.create!(full_name: 'John Doe', email: 'john@example.com', password: 'password', role: 'user')
  #           @user.config
  
  #           post '/users/sign_in', params: { user: { email: 'john@example.com', password: 'password' } }
  #           auth_token = response.headers['Authorization']
  #           delete '/users/sign_out', headers: { 'Authorization' => auth_token }
  
  #           expect(response).to have_http_status(:ok)
  #           json_response = JSON.parse(response.body)
  #           expect(json_response).to include('status', 'message')
  #         end
  #       end
  #     end
  #   end

  #   path '/users/confirmation' do
  #     post 'Send conformation email again' do
  #       tags 'Users'
  #       consumes 'application/json'
  #       produces 'application/json'
  #       parameter name: :user, in: :body, schema: {
  #         type: :object,
  #         properties: {
  #           user: {
  #             type: :object,
  #             properties: {
  #               email: { type: :string },
  #             },
  #             required: %w[email]
  #           }
  #         },
  #         required: %w[user]
  #       }
        
  
  #       response '200', 'Conformation send successfully please check your email' do
  #         schema type: :object,
  #                properties: {
  #                  status: {
  #                    type: :object,
  #                    properties: {
  #                      code: { type: :integer },
  #                      message: { type: :string },

  #                     },
  #                     required: %w[code message]
  #                   },
  #                     },
  #                required: %w[status]
  
  #         run_test! do
        
  #           post '/users/confirmation', params: { user: { email: 'test@example.com' } }
  
  
  #           expect(response).to have_http_status(:ok)
  
  #           json_response = JSON.parse(response.body)
  #           expect(json_response).to include('status')
  #           expect(json_response['status']).to include('code', 'message')
  #         end
  #       end
  
  #       response '401', "Couldn't find an active session" do
  #         schema type: :object,
  #                properties: {
  #                  status: { type: :integer },
  #                  message: { type: :string }
  #                },
  #                required: %w[status message]
  
  #         run_test! do
  #           post '/users/confirmation', params: { user: { email: 'invalid@example.com' } }
  
  #           expect(response).to have_http_status(:unauthorized)
  #           json_response = JSON.parse(response.body)
  #           expect(json_response).to include('status', 'message')
  #         end
  #       end
  #     end
  #   end

  #   path '/users/password' do
  #     post 'Send forget password email' do
  #       tags 'Users'
  #       consumes 'application/json'
  #       produces 'application/json'
  #       parameter name: :user, in: :body, schema: {
  #         type: :object,
  #         properties: {
  #           user: {
  #             type: :object,
  #             properties: {
  #               email: { type: :string },
  #             },
  #             required: %w[email]
  #           }
  #         },
  #         required: %w[user]
  #       }
        
  
  #       response '200', 'Forget password email send successfully' do
  #         schema type: :object,
  #                properties: {
  #                  status: {
  #                    type: :object,
  #                    properties: {
  #                      code: { type: :integer },
  #                      message: { type: :string },

  #                     },
  #                     required: %w[code message]
  #                   },
  #                     },
  #                required: %w[status]
  
  #         run_test! do
        
  #           post '/users/password', params: { user: { email: 'test@example.com' } }
  
  
  #           expect(response).to have_http_status(:ok)
  
  #           json_response = JSON.parse(response.body)
  #           expect(json_response).to include('status')
  #           expect(json_response['status']).to include('code', 'message')
  #         end
  #       end
  
  #       response '401', "Couldn't find an active session" do
  #         schema type: :object,
  #                properties: {
  #                  status: { type: :integer },
  #                  message: { type: :string }
  #                },
  #                required: %w[status message]
  
  #         run_test! do
  #           post '/users/password', params: { user: { email: 'invalid@example.com' } }
  
  #           expect(response).to have_http_status(:unauthorized)
  #           json_response = JSON.parse(response.body)
  #           expect(json_response).to include('status', 'message')
  #         end
  #       end
  #     end
  #   end
  
  
end