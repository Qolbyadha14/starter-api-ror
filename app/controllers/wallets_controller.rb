# app/controllers/wallets_controller.rb
class WalletsController < ApplicationController
  before_action :set_wallet, only: %i[show update destroy]

  def index
    @wallets = Wallet.all
    render json: @wallets
  end

  def show
    render json: @wallet
  end

  def create
    @wallet = Wallet.new(wallet_params)

    if @wallet.save
      render json: @wallet, status: :created
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  def update
    if @wallet.update(wallet_params)
      render json: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @wallet.discard
    head :no_content
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end

  def wallet_params
    params.require(:wallet).permit(:balance, :currency, :walletable_type, :walletable_id)
  end
end
