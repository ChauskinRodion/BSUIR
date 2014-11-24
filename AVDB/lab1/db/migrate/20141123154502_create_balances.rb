class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.decimal :price
      t.boolean :buy_sell

      t.timestamps
    end
  end
end
