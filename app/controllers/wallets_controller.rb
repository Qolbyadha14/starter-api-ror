# app/controllers/wallets_controller.rb
class WalletsController < ApplicationController
  before_action :authenticate_user!

  def credit
    wallet = find_wallet
    amount = params[:amount].to_f
    if amount <= 0
      render json: { error: "Amount must be greater than 0" }, status: :unprocessable_entity
    else
      wallet.credit(amount)
      render json: { success: "Amount credited successfully" }
    end
  end

  def debit
    wallet = find_wallet
    amount = params[:amount].to_f
    if amount <= 0 || wallet.balance_before_type_cast.to_f < amount
      render json: { error: "Invalid debit amount or insufficient balance" }, status: :unprocessable_entity
    else
      wallet.debit(amount)
      render json: { success: "Amount debited successfully" }
    end
  end

  private

  def find_wallet
    @current_user.wallet
  end
end
