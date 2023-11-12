class AddDiscardedAtToWallets < ActiveRecord::Migration[7.1]
  def change
    add_column :wallets, :discarded_at, :datetime
    add_index :wallets, :discarded_at
  end
end
