# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141207225450) do

  create_table "balances", force: true do |t|
    t.decimal  "price"
    t.boolean  "buy_sell"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.integer  "chief_id"
    t.integer  "accountant_id"
    t.integer  "head_company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "nbrb_id"
    t.boolean  "enabled",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currency_rates", force: true do |t|
    t.integer  "currency_id"
    t.datetime "date"
    t.decimal  "value",       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "passport"
    t.string   "phone"
    t.string   "email"
    t.string   "skype"
    t.string   "almamater"
    t.integer  "sex"
    t.integer  "spouse_id"
    t.integer  "mother_id"
    t.integer  "father_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_mails", force: true do |t|
    t.string   "recipient"
    t.string   "sender"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
