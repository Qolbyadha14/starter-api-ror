class CreateTeamWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :team_wallets do |t|
      t.references :wallets, null: false, foreign_key: true
      t.string :team_name

      t.timestamps
    end
  end
end
