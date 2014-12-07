class CreateCurrencyRates < ActiveRecord::Migration
  def change
    create_table :currency_rates do |t|
      t.belongs_to :currency
      t.datetime :date
      t.decimal :value , :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
