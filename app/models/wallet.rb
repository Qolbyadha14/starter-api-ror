class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :transactions
end
