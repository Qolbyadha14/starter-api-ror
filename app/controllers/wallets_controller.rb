class WalletsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Wallet.ransack(params[:q])
    @wallets = @q.result(distinct: true).page(params[:page]).per(10)

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
