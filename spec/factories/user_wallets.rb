FactoryBot.define do
  factory :user_wallet do
    wallets { nil }
    user_type { "Standard" }
    user_id { 1 }
  end
end
