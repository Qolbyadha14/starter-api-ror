require 'swagger_helper'

describe 'Stocks API' do
  path '/stocks' do
    post 'retreive all stock' do
      consumes 'application/json'
      produces 'application/json'
    end
  end
end
