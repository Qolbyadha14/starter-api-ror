class CreateStockWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_wallets do |t|
      t.references :wallets, null: false, foreign_key: true
      t.string :stock_symbol

      t.timestamps
    end
  end
end
