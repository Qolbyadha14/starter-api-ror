require 'rails_helper'

RSpec.describe Stock do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:symbol) }
    it { should validate_uniqueness_of(:symbol) }
  end
end
