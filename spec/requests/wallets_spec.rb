# spec/requests/wallets_spec.rb
require 'swagger_helper'

describe 'Wallets API' do
  include_context 'Authenticated Via JWT'
  before do
    create(:wallet, walletable_id: User.first.id, balance: 200)
  end

  path '/wallets/credit' do
    post 'Credits the wallet with a valid amount' do
      tags 'Wallets'
      consumes 'application/json'
      security [api_key: []]
      parameter name: :request, in: :body, schema: {
        type: :object,
        properties: {
          amount: { type: :number }
        },
        required: %w[amount]
      }

      response '200', 'successful' do
        let(:authorization) { valid_token }
        let(:request) { { amount: 100 } }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json_response = response.parsed_body
          expect(json_response['success']).to eq('Amount credited successfully')
        end
      end

      response '422', 'invalid amount' do
        let(:authorization) { valid_token }
        let(:amount) { -50 }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          json_response = response.parsed_body
          expect(json_response['error']).to eq('Amount must be greater than 0')
        end
      end
    end
  end

  path '/wallets/debit' do
    post 'Debits the wallet with a valid amount' do
      tags 'Wallets'
      consumes 'application/json'
      security [api_key: []]
      parameter name: :request, in: :body, schema: {
        type: :object,
        properties: {
          amount: { type: :number }
        },
        required: %w[amount]
      }

      response '200', 'successful' do
        let(:authorization) { valid_token }
        let(:request) { { amount: 50 } }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'invalid amount or insufficient balance' do
        let(:authorization) { valid_token }
        let(:request) { { amount: 300 } }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          json_response = response.parsed_body
          expect(json_response['error']).to eq('Invalid debit amount or insufficient balance')
        end
      end
    end
  end
end
