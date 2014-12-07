class BalanceController <  ApplicationController

  def index
  end

  def show
    render  json: balances
  end

  def regenerate
    Balance.delete_all
    ActiveRecord::Base.transaction do
      1000.times do
        price = rand *100
        buy_sell = rand(100) % 2
        Balance.create(price: price, buy_sell: buy_sell)
      end
    end
    render  json: balances
  end

  def send_email
    status = validate_params
    if status
      UserMailer.processed_data_email(params).deliver
    end
    render :json => { :success => status }
  end

  private

  def validate_params
    params[:recipient].present?
  end

  def balances
    Balance.all
  end
end
