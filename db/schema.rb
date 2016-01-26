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

ActiveRecord::Schema.define(version: 20160126174428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cartitems", force: :cascade do |t|
    t.integer  "cart_id",    null: false
    t.integer  "item_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "quantity",   null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id",                           null: false
    t.integer  "restaurant_id",                     null: false
    t.string   "status",        default: "pending", null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "str_id",     null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",                null: false
    t.string   "description"
    t.integer  "menusection_id"
    t.integer  "restaurantdetail_id", null: false
    t.string   "price",               null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "menusections", force: :cascade do |t|
    t.string   "name",                null: false
    t.integer  "restaurantdetail_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "opentimes", force: :cascade do |t|
    t.integer  "restaurantdetail_id", null: false
    t.string   "day",                 null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "open_hour"
    t.string   "close_hour"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "restaurant_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "cart_id",       null: false
    t.integer  "status_id",     null: false
    t.integer  "driver_id"
  end

  add_index "orders", ["cart_id"], name: "index_orders_on_cart_id", unique: true, using: :btree

  create_table "restaurantcategories", force: :cascade do |t|
    t.integer  "restaurantdetail_id", null: false
    t.integer  "category_id",         null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "restaurantdetails", force: :cascade do |t|
    t.integer  "restaurant_id", null: false
    t.string   "name",          null: false
    t.string   "description"
    t.string   "locuid",        null: false
    t.string   "phone",         null: false
    t.string   "website_url"
    t.string   "address_one",   null: false
    t.string   "city",          null: false
    t.string   "state",         null: false
    t.string   "zip_code",      null: false
    t.string   "coordinates"
    t.string   "delivery"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "address_two"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "company_name",                        null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "restaurants", ["email"], name: "index_restaurants_on_email", unique: true, using: :btree
  add_index "restaurants", ["reset_password_token"], name: "index_restaurants_on_reset_password_token", unique: true, using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sequence",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                                                        null: false
    t.string   "last_name",                                                         null: false
    t.string   "company_name"
    t.string   "email",                                            default: "",     null: false
    t.string   "encrypted_password",                               default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                    default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.string   "role",                                             default: "user", null: false
    t.decimal  "latitude",               precision: 18, scale: 15
    t.decimal  "longitude",              precision: 18, scale: 15
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
