require 'swagger_helper'

RSpec.describe "wallets" do
  include_context 'Authenticated Via JWT'

  describe 'Wallets' do
    path '/wallets' do
      post 'Creates a Wallets' do
        tags 'Wallets'
        consumes 'application/json'
        security [api_key: []]
        parameter name: :wallet, in: :body, schema: {
          type: :object,
          properties: {
            walletable_type: { type: :string },
            walletable_id: { type: :integer },
            balance: { type: :decimal },
            currency: { type: :string }
          },
          required: %w[walletable_type balance currency]
        }

        response '201', 'wallet created' do
          let(:wallet) { { balance: 100.0, currency: 'USD', walletable_type: 'User', walletable_id: User.first.id } }
          let(:authorization) { valid_token }
          run_test! do |response|
            expect(response).to have_http_status(:created)
            data = JSON.parse(response.body)
            expect(data['balance']).to eq("100.0")
            expect(data['currency']).to eq('USD')
            expect(data['walletable_type']).to eq('User')
            expect(data['walletable_id']).to eq(User.first.id)
          end
        end

        response '422', 'invalid request' do
          let(:wallet) { { balance: 'invalid' } }
          let(:authorization) { valid_token }
          run_test! do |response|
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end
  end
end
