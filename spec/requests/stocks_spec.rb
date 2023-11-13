require 'swagger_helper'

describe 'Stocks API' do
  path '/stocks' do
    post 'Creates a stock' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :stock, in: :body, schema: {
        type: :object,
        properties: {
          symbol: { type: :string },
          name: { type: :string },
          price: { type: :float },
          exchange: { type: :string }
        },
        required: %w[username password]
      }

      response '201', 'stock created' do
        schema type: :object, properties: {
          id: { type: :integer },
          symbol: { type: :string },
          name: { type: :string },
          price: { type: :string },
          exchange: { type: :string }
        },
        required: %w[id symbol name]

        let(:stock) { { symbol: 'AAPL', name: 'APPLE.INC', price: 160.00, exchange: 'NASDAQ' } }
        run_test! do |response|
          expect(response).to have_http_status(:created)
          json_response = response.parsed_body
          expect(json_response['symbol']).to eq('AAPL')
          expect(json_response['name']).to eq('APPLE.INC')
          expect(json_response['price']).to eq("160.0")
          expect(json_response['exchange']).to eq('NASDAQ')
        end
      end

      response '422', 'invalid request' do
        before do
          create(:stock, symbol: 'AAPL', name: 'APPLE.INC', price: 160.00, exchange: 'NASDAQ')
        end

        context 'when name is missing' do
          let(:stock) { { symbol: 'AAPL' } }
          run_test! do |response|
            expect(response).to have_http_status(:unprocessable_entity)
            json_response = response.parsed_body
            expect(json_response['name']).to include("can't be blank")
          end
        end

        context 'when symbol is same' do
          let(:stock) { { symbol: 'AAPL', name: 'APPLE.INC', price: 160.00, exchange: 'NASDAQ' } }
          run_test! do |response|
            expect(response).to have_http_status(:unprocessable_entity)
            json_response = response.parsed_body
            expect(json_response['symbol']).to include("has already been taken")
          end
        end
      end
    end
  end

  path '/stocks/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieves a stock' do
      produces 'application/json'
      response '200', 'stock found' do
        schema type: :object, properties: {
                 id: { type: :integer },
                 symbol: { type: :string },
                 name: { type: :string },
                 price: { type: :string },
                 exchange: { type: :string }
               }

        let(:id) { Stock.create(symbol: 'AAPL', name: 'APPLE.INC', price: 160.00, exchange: 'NASDAQ').id }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json_response = response.parsed_body
          expect(json_response['symbol']).to eq('AAPL')
          expect(json_response['name']).to eq('APPLE.INC')
          expect(json_response['price']).to eq("160.0")
          expect(json_response['exchange']).to eq('NASDAQ')
        end
      end

      response '404', 'stock not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a stock' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :stock, in: :body, schema: {
        type: :object,
        properties: {
          symbol: { type: :string },
          name: { type: :string },
          price: { type: :number },
          exchange: { type: :string }
        },
        required: ['symbol', 'name']
      }

      response '200', 'stock updated' do
        schema type: :object, properties: {
          id: { type: :integer },
          symbol: { type: :string },
          name: { type: :string },
          price: { type: :string },
          exchange: { type: :string }
        }

        let(:id) { Stock.create(symbol: 'AAPL', name: 'Apple Inc.').id }
        let(:stock) { { symbol: 'AAPL', name: 'Apple Inc.', price: 160.00, exchange: 'NASDAQ' } }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json_response = response.parsed_body
          expect(json_response['symbol']).to eq('AAPL')
          expect(json_response['name']).to eq('Apple Inc.')
          expect(json_response['price']).to eq("160.0")
          expect(json_response['exchange']).to eq('NASDAQ')
        end
      end

      response '422', 'invalid request' do
        let(:id) { Stock.create(symbol: 'AAPL', name: 'Apple Inc.').id }
        let(:stock) { { symbol: 'AAPL', name: '' } }
        run_test!
      end
    end

    delete 'Deletes a stock' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'stock deleted' do
        let(:id) { Stock.create(symbol: 'AAPL', name: 'Apple Inc.').id }
        run_test! do |response|
          expect(response).to have_http_status(:no_content)
        end
      end

      response '404', 'stock not found' do
        let(:id) { 'invalid' }
        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
