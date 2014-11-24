# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.balance)

Balance.destroy_all
N = 100
N.times do
  price = rand *100
  buy_sell = rand(100) % 2
  Balance.create(price: price, buy_sell: buy_sell)
end
