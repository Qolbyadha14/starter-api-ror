require 'swagger_helper'

RSpec.describe "Sessions" do
  before do
    create(:user, username: 'test', password: '123456')
  end

  describe "posy /sessions" do
    path '/sessions' do
      post 'Login Auth' do
        tags 'Sessions'
        consumes 'application/json'
        parameter name: :login, in: :body, schema: {
          type: :object,
          properties: {
            username: { type: :string },
            password: { type: :string }
          },
          required: %w[username password]
        }

        response '200', 'Auth Success' do
          let(:login) { { username: 'test', password: '123456' } }
          run_test! do
            expect(response).to have_http_status(:ok)
            expect(response.body).to include('token')
          end
        end

        response '401', 'Auth Failed' do
          let(:login) { { username: 'test', password: '1234567' } }
          run_test! do
            expect(response).to have_http_status(:unauthorized)
            expect(response.body).to include('Invalid username or password')
          end
        end
      end
    end
  end
end
