FactoryBot.define do
  factory :credit_transaction do
    amount { 100 }
    target_wallet_id { association :wallet }
  end
end
