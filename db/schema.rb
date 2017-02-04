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

ActiveRecord::Schema.define(version: 20170204011559) do

  create_table "delivery_options", force: :cascade do |t|
    t.string  "name"
    t.integer "min_days"
    t.integer "max_days"
    t.boolean "default_active", default: false
    t.boolean "business_day"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "total",              precision: 8, scale: 2
    t.decimal "subtotal_items",     precision: 8, scale: 2
    t.decimal "discount",           precision: 8, scale: 2
    t.decimal "shipping_cost",      precision: 8, scale: 2
    t.integer "shipping_detail_id"
    t.string  "state"
  end

  create_table "product_reviews", force: :cascade do |t|
    t.string   "reviewer"
    t.string   "comment"
    t.integer  "rating"
    t.datetime "review_date"
    t.integer  "product_id"
  end

  create_table "product_tenants", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.string  "author"
    t.decimal "price",       precision: 8, scale: 2
    t.string  "img"
    t.string  "tenant"
  end

  create_table "products", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.string  "author"
    t.decimal "price",       precision: 8, scale: 2
    t.string  "img"
  end

  create_table "shipping_details", force: :cascade do |t|
    t.string  "full_name"
    t.string  "address_line"
    t.string  "city"
    t.string  "country"
    t.integer "delivery_option_id"
  end

end
