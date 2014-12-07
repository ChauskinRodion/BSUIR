class CurrencyRatesUpdateWorker
  include Sidekiq::Worker

  def perform
    @client = Savon::Client.new(wsdl: 'http://www.nbrb.by/Services/ExRates.asmx?WSDL')

    Currency.all.each_with_index do |currency, i|
      print "\r#{i}/#{Currency.count}"
      currency.currency_rates.destroy_all
      create_currency_rates(currency)
    end
  end

  private
  def create_currency_rates(currency)
    response = @client.call(:ex_rates_dyn, message: {
        "fromDate" => 1.month.ago.strftime('%F'),
        'toDate' => DateTime.now.strftime("%F"),
        'curId' => currency.nbrb_id
    })
    unless response.body[:ex_rates_dyn_response][:ex_rates_dyn_result].nil?
      rates_array = response.body[:ex_rates_dyn_response][:ex_rates_dyn_result][:diffgram][:new_data_set][:currency]
      if rates_array.class == Array
        rates_array.each do |x|
          CurrencyRate.create(currency: currency, date: x[:date], value: x[:cur_official_rate])
        end
      elsif rates_array.class == Hash
        CurrencyRate.create(currency: currency, date: rates_array[:date], value: rates_array[:cur_official_rate])
      end
    end
  end
end
