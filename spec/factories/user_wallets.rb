FactoryBot.define do
  factory :user_wallet do
    wallets { nil }
    user_type { "MyString" }
    user_id { 1 }
  end
end
