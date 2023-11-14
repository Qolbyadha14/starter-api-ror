class Wallet < ApplicationRecord
  include Discard::Model

  belongs_to :walletable, polymorphic: true

  scope :active, -> { kept }
  scope :inactive, -> { discarded }

  validates :balance, :walletable_type, :currency, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[walletable_type currency id]
  end
end
