class Wallet < ApplicationRecord
  include Discard::Model

  belongs_to :walletable, polymorphic: true
  has_many :credit_transactions, foreign_key: 'target_wallet_id', class_name: 'CreditTransaction'
  has_many :debit_transactions, foreign_key: 'source_wallet_id', class_name: 'DebitTransaction'

  scope :active, -> { kept }
  scope :inactive, -> { discarded }

  validates :balance, :walletable_type, :currency, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[walletable_type currency id]
  end

  def balance
    credit_transactions.sum(:amount) - debit_transactions.sum(:amount)
  end

  def credit(amount)
    credit_transactions.create!(amount:)
  end

  def debit(amount)
    debit_transactions.create!(amount:)
  end
end
