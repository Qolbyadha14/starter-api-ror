# spec/models/wallet_spec.rb
require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:walletable) }

    it {
      expect(subject).to have_many(:credit_transactions).class_name('CreditTransaction').with_foreign_key('target_wallet_id')
    }

    it {
      expect(subject).to have_many(:debit_transactions).class_name('DebitTransaction').with_foreign_key('source_wallet_id')
    }
  end

  describe "methods" do
    before do
      create(:user, id: 1)
      create(:wallet, id: 1, walletable_id: User.find(1).id)
    end

    let(:wallet) { described_class.find(1) }

    it "calculates balance correctly" do
      create(:credit_transaction, target_wallet_id: wallet.id, amount: 100)
      create(:debit_transaction, source_wallet_id: wallet.id, amount: 50)
      expect(wallet.balance).to eq(50)
    end

    it "credits the wallet" do
      wallet.credit(200)
      expect(wallet.credit_transactions.count).to eq(1)
      expect(wallet.credit_transactions.first.amount).to eq(200)
    end

    it "debits the wallet" do
      wallet.debit(50)
      expect(wallet.debit_transactions.count).to eq(1)
      expect(wallet.debit_transactions.first.amount).to eq(50)
    end
  end
end
