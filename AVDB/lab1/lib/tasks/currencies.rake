namespace :currencies do
    desc "Update"

    task :update => :environment  do
      client = Savon::Client.new(wsdl: 'http://www.nbrb.by/Services/ExRates.asmx?WSDL')

      response = client.call(:currencies_ref, message: { "Periodicity" => 1000 })
      currency_hash = response.body.to_hash[:currencies_ref_response][:currencies_ref_result][:diffgram][:new_data_set][:daily_currencies_ref]

      currency_hash.each do|x|
        nbrb_currency_hash = {name: x[:cur_name_eng], code: x[:cur_abbreviation], nbrb_id: x[:cur_id]}
        old_currency = Currency.find_by(nbrb_id: x[:cur_id])
        if old_currency
          old_currency.update_attributes(nbrb_currency_hash)
        else
          Currency.create(nbrb_currency_hash)
        end
      end
    end
end
