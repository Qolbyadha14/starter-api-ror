# spec/requests/wallets_spec.rb
require 'swagger_helper'

describe 'Wallets API' do
  include_context 'Authenticated Via JWT'

  before do
    create(:wallet, id: 1, balance: 100.0, currency: 'USD', walletable_type: 'User', walletable_id: User.first.id)
    create(:user, id: 2, username: 'johndoe', password: 'password')
  end

  path '/wallets' do
    get 'Retrieves a list of wallets' do
      produces 'application/json'

      response '200', 'wallets found' do
        run_test!
      end
    end

    post 'Creates a wallet' do
      consumes 'application/json'
      produces 'application/json'
      security [api_key: []]
      parameter name: :wallet, in: :body, schema: {
        type: :object,
        properties: {
          balance: { type: :number },
          currency: { type: :string },
          walletable_type: { type: :string },
          walletable_id: { type: :integer }
        },
        required: %w[balance currency walletable_type walletable_id]
      }

      response '201', 'wallet created' do
        let(:authorization) { valid_token }
        let(:wallet) { { balance: 100.00, currency: 'USD', walletable_type: 'User', walletable_id: User.find(2).id } }
        run_test! do |response|
          expect(response).to have_http_status(:created)
          json_response = response.parsed_body
          expect(json_response['balance']).to eq("100.0")
          expect(json_response['currency']).to eq('USD')
          expect(json_response['walletable_type']).to eq('User')
        end
      end

      response '422', 'invalid request' do
        let(:authorization) { valid_token }
        let(:wallet) { { balance: 100.00 } }
        run_test!
      end
    end
  end

  path '/wallets/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieves a wallet' do
      consumes 'application/json'
      produces 'application/json'
      security [api_key: []]

      response '200', 'wallet found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 balance: { type: :string },
                 currency: { type: :string },
                 walletable_type: { type: :string },
                 walletable_id: { type: :integer }
               },
               required: %w[id balance currency walletable_type walletable_id]
        let(:id) do
          Wallet.create(balance: 100.0, currency: 'USD', walletable_type: 'User', walletable_id: User.find(2).id).id
        end
        let(:authorization) { valid_token }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json_response = response.parsed_body
          expect(json_response['balance']).to eq("100.0")
          expect(json_response['currency']).to eq('USD')
          expect(json_response['walletable_type']).to eq('User')
          expect(json_response['walletable_id']).to eq(User.find(2).id)
        end
      end

      response '404', 'wallet not found' do
        let(:authorization) { valid_token }
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a wallet' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :wallet, in: :body, schema: {
        type: :object,
        properties: {
          balance: { type: :number },
          currency: { type: :string },
          walletable_type: { type: :string },
          walletable_id: { type: :integer }
        },
        required: %w[balance currency walletable_type walletable_id]
      }

      response '200', 'wallet updated' do
        let(:authorization) { valid_token }
        let(:id) { Wallet.find(1).id }
        let(:wallet) { { balance: 150.00, currency: 'USD', walletable_type: 'User', walletable_id: User.find(2).id } }
        run_test! do
          expect(response).to have_http_status(:ok)
          json_response = response.parsed_body
          expect(json_response['balance']).to eq("150.0")
          expect(json_response['currency']).to eq('USD')
          expect(json_response['walletable_type']).to eq('User')
          expect(json_response['walletable_id']).to eq(User.find(2).id)
        end
      end

      response '422', 'invalid request' do
        let(:authorization) { valid_token }
        let(:id) { Wallet.find(1).id }
        let(:wallet) { { balance: -1, currency: 'USD' } }
        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
          json_response = response.parsed_body
          expect(json_response['balance']).to eq(['must be greater than or equal to 0'])
        end
      end
    end

    delete 'Deletes a wallet' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'wallet deleted' do
        let(:id) do
          Wallet.create(balance: 100.0, currency: 'USD', walletable_type: 'User', walletable_id: User.find(2).id).id
        end
        let(:authorization) { valid_token }
        run_test! do |response|
          expect(response).to have_http_status(:no_content)
        end
      end

      response '404', 'wallet not found' do
        let(:authorization) { valid_token }
        let(:id) { 'invalid' }
        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
