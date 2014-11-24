class BalanceController <  ApplicationController

  def index
  end

  def show
    render  json: balances
  end

  def regenerate
    Balance.all.each do |balance|
      price = rand *100
      buy_sell = rand(100) % 2
      balance.update_attributes(price: price, buy_sell: buy_sell)
    end
    render  json: balances
  end

  private

  def balances
    Balance.all
  end
end
