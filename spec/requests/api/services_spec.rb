require 'rails_helper'

RSpec.describe 'Api::Services', type: :request do
  describe 'GET /index' do

    path '/api/services' do

      get 'Retrieves a cars' do
        tags 'Cars'
        produces 'application/json'

        # request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'
  
        response '200', 'cars list' do
          schema type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              image: { type: :string },
              price: {type: :string},
              details: {type: :string},
            },
            required: [ 'id', 'name', 'image', 'details', 'price' ]
  
          let(:id) { Service.create(name: 'foo', image: 'bar.jpg').id }
          run_test!
        end
  
        response '404', 'Car not found' do
          let(:id) { 'invalid' }
          run_test!
        end
  
        response '406', 'unsupported accept header' do
          let(:'Accept') { 'application/foo' }
          run_test!
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
          schema type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              image: { type: :string },
              price: {type: :string},
              details: {type: :string},
            },
            required: [ 'id', 'name', 'image', 'details', 'price' ]
  
          let(:id) { Service.create(name: 'foo', image: 'bar.jpg').id }
          run_test!
        end
  
        response '404', 'Car not found' do
          let(:id) { 'invalid' }
          run_test!
        end
  
        response '406', 'unsupported accept header' do
          let(:'Accept') { 'application/foo' }
          run_test!
        end
      end
    end
  end

  # describe 'DELETE /destory' do

  #   path '/api/services/{id}' do

  #     delete 'Delete a car' do
  #       tags 'Cars'
  #       produces 'application/json'
  #       parameter name: :id, in: :path, type: :string
  
  #       response '200', 'Car' do
  #         schema type: :object,
  #         properties: {
  #           message: "Deleted"
  #         }
  
  #         run_test!
  #       end
  
  #       response '404', 'Car not found' do
  #         let(:id) { 'invalid' }
  #         run_test!
  #       end
  
  #       response '406', 'unsupported accept header' do
  #         let(:'Accept') { 'application/foo' }
  #         run_test!
  #       end
  #     end
  #   end
  # end

  # describe 'GET /create' do

  #   path '/api/services' do

  #     post 'Create a car' do
  #       tags 'Cars'
  #       produces 'application/json'
  #       parameter name: :services, in: :body, schema: {
  #         type: :object,
  #         properties: {
  #           name: { type: :string },
  #           image: { type: :string },
  #           price: {type: :number},
  #           details: {type: :string},
  #           duration: {type: :number},
  #         },
  #         required: [ 'name', 'image', 'price' ]
  #       }
  
  #       response '201', 'Car created' do
  #         let(:id) { Service.create(name: 'foo', image: 'bar.jpg', price: 10).id }
  #         run_test!
  #       end
  
  #       response '422', 'invalid request' do
  #         let(:blog) { { name: 'foo' } }
  #         run_test!
  #       end
  #     end
  #   end
  # end
end
