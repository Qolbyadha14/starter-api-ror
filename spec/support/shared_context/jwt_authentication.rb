require 'rails_helper'

RSpec.shared_context 'Authenticated Via JWT' do
  before do
    create(:user)
  end
  let(:valid_token) { JWT.encode({user_id: User.first.id}, 'your_secret_key', 'HS256') }
end
