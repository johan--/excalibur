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

ActiveRecord::Schema.define(version: 20150601232744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courts", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "price",      null: false
    t.string   "unit",       null: false
    t.integer  "category",   null: false
    t.integer  "venue_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courts", ["venue_id"], name: "index_courts_on_venue_id", using: :btree

  create_table "firms", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "city",       null: false
    t.string   "address",    null: false
    t.string   "phone",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "firms", ["city"], name: "index_firms_on_city", using: :btree
  add_index "firms", ["name"], name: "index_firms_on_name", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "installments", force: :cascade do |t|
    t.integer  "reservation_id", null: false
    t.integer  "user_id",        null: false
    t.datetime "pay_day",        null: false
    t.string   "pay_code",       null: false
    t.integer  "total",          null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "installments", ["pay_code"], name: "index_installments_on_pay_code", using: :btree
  add_index "installments", ["reservation_id"], name: "index_installments_on_reservation_id", using: :btree
  add_index "installments", ["user_id"], name: "index_installments_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "subscription_id", null: false
    t.string   "pay_code",        null: false
    t.datetime "pay_day",         null: false
    t.integer  "total",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "payments", ["pay_code"], name: "index_payments_on_pay_code", using: :btree
  add_index "payments", ["subscription_id"], name: "index_payments_on_subscription_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content_md"
    t.text     "content_html"
    t.boolean  "draft",        default: false
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id",   null: false
    t.string   "followed_type", null: false
    t.integer  "followed_id",   null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "relationships", ["followed_id", "followed_type"], name: "index_relationships_on_followed_id_and_followed_type", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "reservation_transitions", force: :cascade do |t|
    t.string   "to_state",                      null: false
    t.text     "metadata",       default: "{}"
    t.integer  "sort_key",                      null: false
    t.integer  "reservation_id",                null: false
    t.boolean  "most_recent",                   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "reservation_transitions", ["reservation_id", "most_recent"], name: "index_reservation_transitions_parent_most_recent", unique: true, where: "most_recent", using: :btree
  add_index "reservation_transitions", ["reservation_id", "sort_key"], name: "index_reservation_transitions_parent_sort", unique: true, using: :btree

  create_table "reservations", force: :cascade do |t|
    t.date     "date_reserved", null: false
    t.time     "start",         null: false
    t.decimal  "duration",      null: false
    t.time     "finish",        null: false
    t.integer  "charge",        null: false
    t.integer  "court_id",      null: false
    t.integer  "booker_id",     null: false
    t.string   "booker_type",   null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "reservations", ["booker_type", "booker_id"], name: "index_reservations_on_booker_type_and_booker_id", using: :btree
  add_index "reservations", ["court_id"], name: "index_reservations_on_court_id", using: :btree

  create_table "rosters", force: :cascade do |t|
    t.integer  "rosterable_id",   null: false
    t.string   "rosterable_type", null: false
    t.integer  "user_id",         null: false
    t.integer  "role"
    t.datetime "deleted_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "rosters", ["deleted_at"], name: "index_rosters_on_deleted_at", using: :btree
  add_index "rosters", ["rosterable_type", "rosterable_id", "user_id"], name: "index_rosters_on_rosterable_type_and_rosterable_id_and_user_id", using: :btree
  add_index "rosters", ["rosterable_type", "rosterable_id"], name: "index_rosters_on_rosterable_type_and_rosterable_id", using: :btree
  add_index "rosters", ["user_id"], name: "index_rosters_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "category",   null: false
    t.integer  "firm_id",    null: false
    t.integer  "status",     null: false
    t.date     "start_date", null: false
    t.date     "end_date",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["firm_id"], name: "index_subscriptions_on_firm_id", using: :btree
  add_index "subscriptions", ["status"], name: "index_subscriptions_on_status", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "locked",                 default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number",                           null: false
    t.string   "full_name",                              null: false
    t.datetime "deleted_at"
    t.integer  "category",                               null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "province",               null: false
    t.string   "city",                   null: false
    t.string   "address",                null: false
    t.integer  "rating",     default: 0, null: false
    t.string   "phone"
    t.integer  "firm_id",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "venues", ["firm_id"], name: "index_venues_on_firm_id", using: :btree

  add_foreign_key "courts", "venues"
  add_foreign_key "venues", "firms"
end
