# lib/latest_stock_price.rb

require 'net/http'
require 'json'

module LatestStockPrice
  # TODO: Replace with env
  API_BASE_URL = "https://latest-stock-price.p.rapidapi.com"
  API_KEY = "ac9792499fmsh5e55363eb59f8cfp1a5394jsn1c240e4da868"
  API_HOST = "latest-stock-price.p.rapidapi.com"

  def self.price(symbol)
    url = URI("#{API_BASE_URL}/price?Indices=#{symbol}")
    fetch_data(url)
  end

  def self.price_all
    url = URI("#{API_BASE_URL}/any")
    fetch_data(url)
  end

  def self.fetch_data(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'ac9792499fmsh5e55363eb59f8cfp1a5394jsn1c240e4da868'
    request["X-RapidAPI-Host"] = 'latest-stock-price.p.rapidapi.com'

    response = http.request(request)
    response.read_body
  rescue StandardError => e
    Rails.logger.error("Error fetching data: #{e.message}")
    nil
  end
end
