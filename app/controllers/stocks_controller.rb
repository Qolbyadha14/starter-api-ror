# app/controllers/stocks_controller.rb
class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    stock_price = LatestStockPrice.price_all
    render json: { data: stock_price }, status: :ok
  end
end
