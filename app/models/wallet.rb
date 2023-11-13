class Wallet < ApplicationRecord
  include Discard::Model

  belongs_to :walletable, polymorphic: true
  has_many :transactions

  scope :active, -> { kept }
  scope :inactive, -> { discarded }

  validates :balance, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[walletable_type currency walletable_id id]
  end
end
