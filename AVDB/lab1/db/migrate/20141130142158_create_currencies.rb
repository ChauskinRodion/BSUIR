require 'app/models/currency'

class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies  do |t|
      t.string :name
      t.string :code
      t.integer :nbrb_id

      t.boolean :enabled, :default => false

      t.timestamps
    end
  end
end
