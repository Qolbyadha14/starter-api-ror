# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_12_131015) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stock_wallets", force: :cascade do |t|
    t.bigint "wallets_id", null: false
    t.string "stock_symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wallets_id"], name: "index_stock_wallets_on_wallets_id"
  end

  create_table "team_wallets", force: :cascade do |t|
    t.bigint "wallets_id", null: false
    t.string "team_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wallets_id"], name: "index_team_wallets_on_wallets_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "source_wallet_id"
    t.bigint "target_wallet_id"
    t.decimal "amount", precision: 10, scale: 2
    t.string "transaction_type"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_wallet_id"], name: "index_transactions_on_source_wallet_id"
    t.index ["target_wallet_id"], name: "index_transactions_on_target_wallet_id"
  end

  create_table "user_wallets", force: :cascade do |t|
    t.bigint "wallets_id", null: false
    t.string "user_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wallets_id"], name: "index_user_wallets_on_wallets_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.string "walletable_type", null: false
    t.bigint "walletable_id", null: false
    t.decimal "balance", precision: 10, scale: 2
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_wallets_on_discarded_at"
    t.index ["walletable_type", "walletable_id"], name: "index_wallets_on_walletable"
  end

  add_foreign_key "stock_wallets", "wallets", column: "wallets_id"
  add_foreign_key "team_wallets", "wallets", column: "wallets_id"
  add_foreign_key "transactions", "wallets", column: "source_wallet_id"
  add_foreign_key "transactions", "wallets", column: "target_wallet_id"
  add_foreign_key "user_wallets", "wallets", column: "wallets_id"
end
