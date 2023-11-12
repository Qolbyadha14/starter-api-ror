FactoryBot.define do
  factory :transaction do
    source_wallet { nil }
    target_wallet { nil }
    amount { "9.99" }
    transaction_type { "MyString" }
    description { "MyString" }
  end
end
