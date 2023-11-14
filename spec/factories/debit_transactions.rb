# spec/factories/debit_transactions.rb
FactoryBot.define do
  factory :debit_transaction do
    amount { 50 }
    source_wallet_id { association :wallet }
  end
end
