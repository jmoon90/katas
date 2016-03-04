require 'byebug'

class StockPrice
  attr_accessor :stock_prices_yesterday, :min_price, :max_price
  def initialize(stock_prices_yesterday)
    not_enough_prices if stock_prices_yesterday.length < 2

    @stock_prices_yesterday = stock_prices_yesterday
    @min_price = stock_prices_yesterday.first
    @max_price = stock_prices_yesterday[1] - stock_prices_yesterday[0]
  end

  def get_max_profit


    stock_prices_yesterday.each_with_index do |price, index|
      if index == 0 then next end
      potential_profit = price - min_price
      @max_price = [max_price, potential_profit].max
      @min_price = [min_price, price].min
    end
    puts max_price
  end

  def not_enough_prices
    raise IndexError, 'Getting a profit requires at least 2 prices'
  end
end

stock_prices_yesterday = [-10, -7, -15]
StockPrice.new(stock_prices_yesterday).get_max_profit
