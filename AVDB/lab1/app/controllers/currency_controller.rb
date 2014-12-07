class CurrencyController <  ApplicationController

  def index
  end

  def show
    date = DateTime.parse params[:date]
    result = build_data(date)
    render json: result
  end

  def update
    success = Currency.find(params[:id]).update_attributes(enabled: params[:enabled])
    render :json => { :success => success }
  end

  def get_history
    id = params[:id].to_i
    start_date = Currency.find(id).currency_rates.order(date: :asc).first.try(:date)
    points = Currency.find(id).currency_rates.map(&:value)
    render json: {points: points, start_date: start_date}
  end

  private
  def build_data(date)
    Currency.all.map do |currency|
      last_rate = currency.currency_rates.order(date: :desc).first
      date_rate = currency.currency_rates.find_by("date > '#{date.strftime('%F')}'")
      {
          id: currency.id,
          name: currency.name,
          code: currency.code,
          last_rate: last_rate.try(:value),
          last_date: last_rate.try(:date),
          date_rate: date_rate.try(:value),
          enabled: currency.enabled
      }
    end
  end

end
