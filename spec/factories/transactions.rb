FactoryBot.define do
  factory :transaction do
    source_wallet { nil }
    target_wallet { nil }
    amount { "9.99" }
    transaction_type { "Debit" }
    description { "Withdrawal" }
  end
end
