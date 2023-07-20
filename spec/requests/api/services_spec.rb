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
end
