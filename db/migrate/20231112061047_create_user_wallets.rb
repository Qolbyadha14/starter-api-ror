class CreateUserWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :user_wallets do |t|
      t.references :wallets, null: false, foreign_key: true
      t.string :user_type
      t.integer :user_id

      t.timestamps
    end
  end
end
