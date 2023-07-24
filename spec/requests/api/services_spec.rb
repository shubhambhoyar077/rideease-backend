require 'swagger_helper'

RSpec.describe 'Api::Services', type: :request do
  before do
    @service = Service.create(name: 'test', image: 'test.jpg')
  end
  describe 'GET /index' do
    path '/api/services' do
      get 'Retrieves a cars' do
        tags 'Cars'
        produces 'application/json'

        response '200', 'cars list' do
          run_test! do |response|
            expect(response).to have_http_status(:ok)
          end
        end
      end
    end
  end

  describe 'GET /show' do
    path '/api/services/{id}' do
      get 'Retrieves a car' do
        tags 'Cars'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '200', 'Car' do
          let(:id) { Service.create(name: 'foo', image: 'bar.jpg').id }
          run_test! do |response|
            expect(response.body).to include('foo')
            expect(response.body).to include('bar.jpg')
          end
        end
      end
    end
  end

  describe 'DELETE /destory' do
    path '/api/services/{id}' do
      delete 'Delete a car' do
        tags 'Cars'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '200', 'Car' do
          let(:id) { @service.id }
          run_test!
        end
      end
    end
  end
end
