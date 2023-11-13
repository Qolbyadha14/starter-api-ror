# spec/requests/teams_spec.rb
require 'swagger_helper'

describe 'Teams API' do
  before do
    create(:team, id: 1, name: 'Engineering', description: 'Software development team')
  end

  path '/teams' do
    get 'Retrieves a list of teams' do
      consumes 'application/json'
      produces 'application/json'

      response '200', 'teams found' do
        run_test! do |_response|
          expect(response).to have_http_status(:ok)
          json_response = response.parsed_body
          expect(json_response.size).to eq(1)
          expect(json_response.first['name']).to eq('Engineering')
          expect(json_response.first['description']).to eq('Software development team')
        end
      end
    end

    post 'Creates a team' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: ['name']
      }

      response '201', 'team created' do
        let(:team) { { name: 'Business', description: 'Business development team' } }
        run_test! do |response|
          expect(response).to have_http_status(:created)
          json_response = response.parsed_body
          expect(json_response['name']).to eq('Business')
          expect(json_response['description']).to eq('Business development team')
        end
      end

      response '422', 'invalid request' do
        let(:team) { { name: '' } }
        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  path '/teams/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieves a team' do
      produces 'application/json'
      response '200', 'team found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string }
               },
               required: %w[id name]
        let(:id) { Team.find(1).id }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json_response = response.parsed_body
          expect(json_response['name']).to eq('Engineering')
          expect(json_response['description']).to eq('Software development team')
        end
      end

      response '404', 'team not found' do
        let(:id) { 'invalid' }
        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    put 'Updates a team' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: ['name']
      }

      response '200', 'team updated' do
        let(:id) { Team.find(1).id }
        let(:team) { { name: 'Marketing', description: 'Product promotion team' } }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json_response = response.parsed_body
          expect(json_response['name']).to eq('Marketing')
          expect(json_response['description']).to eq('Product promotion team')
        end
      end

      response '422', 'invalid request' do
        let(:id) { Team.find(1).id }
        let(:team) { { name: '' } }
        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body).to eq('name' => ["can't be blank"])
        end
      end
    end

    delete 'Deletes a team' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'team deleted' do
        let(:id) { Team.create(name: 'Engineering', description: 'Software development team').id }
        run_test! do |response|
          expect(response).to have_http_status(:no_content)
        end
      end

      response '404', 'team not found' do
        let(:id) { 'invalid' }
        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
