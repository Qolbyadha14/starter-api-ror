FactoryBot.define do
  factory :wallet do
    walletable { nil }
    balance { "9.99" }
    currency { "IDR" }
  end
end
