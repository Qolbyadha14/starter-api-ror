class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :valid_wallets

  private

  def valid_wallets
    return unless source_wallet.nil? && target_wallet.nil?

    errors.add(:base, "Either source or target wallet must be present")
  end
end
