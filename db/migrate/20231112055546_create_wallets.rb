class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.references :walletable, polymorphic: true, null: false
      t.decimal :balance, precision: 10, scale: 2
      t.string :currency

      t.timestamps
    end
  end
end
