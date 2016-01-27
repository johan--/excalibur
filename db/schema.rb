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

ActiveRecord::Schema.define(version: 20160121231258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "ahoy_events", id: :uuid, force: :cascade do |t|
    t.uuid     "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.jsonb    "properties"
    t.datetime "time",       null: false
  end

  add_index "ahoy_events", ["time"], name: "index_ahoy_events_on_time", using: :btree
  add_index "ahoy_events", ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
  add_index "ahoy_events", ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree

  create_table "attachinary_files", force: :cascade do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "bids", force: :cascade do |t|
    t.integer  "bidder_id",                                null: false
    t.string   "bidder_type",                              null: false
    t.integer  "tender_id",                                null: false
    t.string   "ticker"
    t.integer  "volume",                                   null: false
    t.integer  "price_sens",     limit: 8, default: 0,     null: false
    t.string   "price_currency",           default: "IDR", null: false
    t.jsonb    "details",                  default: {}
    t.string   "slug",                                     null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "bids", ["bidder_type", "bidder_id"], name: "index_bids_on_bidder_type_and_bidder_id", using: :btree
  add_index "bids", ["deleted_at"], name: "index_bids_on_deleted_at", using: :btree
  add_index "bids", ["details"], name: "index_bids_on_details", using: :gin
  add_index "bids", ["slug"], name: "index_bids_on_slug", using: :btree
  add_index "bids", ["tender_id"], name: "index_bids_on_tender_id", using: :btree
  add_index "bids", ["ticker"], name: "index_bids_on_ticker", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
    t.string   "title"
    t.text     "body_html"
    t.text     "body_md"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.jsonb    "details"
    t.datetime "deleted_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["deleted_at"], name: "index_comments_on_deleted_at", using: :btree
  add_index "comments", ["details"], name: "index_comments_on_details", using: :gin
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.integer  "tender_id",  null: false
    t.string   "type"
    t.string   "aqad",       null: false
    t.string   "ticker",     null: false
    t.string   "slug"
    t.jsonb    "details"
    t.date     "begin_at"
    t.date     "end_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contracts", ["deleted_at"], name: "index_contracts_on_deleted_at", using: :btree
  add_index "contracts", ["slug"], name: "index_contracts_on_slug", using: :btree
  add_index "contracts", ["tender_id"], name: "index_contracts_on_tender_id", using: :btree

  create_table "custom_auto_increments", force: :cascade do |t|
    t.string   "counter_model_name"
    t.integer  "counter",            default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "custom_auto_increments", ["counter_model_name"], name: "index_custom_auto_increments_on_counter_model_name", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "ticker",     null: false
    t.string   "type"
    t.string   "category"
    t.string   "slug",       null: false
    t.jsonb    "details"
    t.integer  "owner_id",   null: false
    t.string   "owner_type", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "documents", ["deleted_at"], name: "index_documents_on_deleted_at", using: :btree
  add_index "documents", ["details"], name: "index_documents_on_details", using: :gin
  add_index "documents", ["slug"], name: "index_documents_on_slug", unique: true, using: :btree

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

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "member_id",       null: false
    t.string   "member_type",     null: false
    t.integer  "group_id"
    t.string   "group_type"
    t.string   "group_name"
    t.string   "membership_type"
    t.jsonb    "details"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "group_memberships", ["details"], name: "index_group_memberships_on_details", using: :gin
  add_index "group_memberships", ["group_name"], name: "index_group_memberships_on_group_name", using: :btree
  add_index "group_memberships", ["group_type", "group_id"], name: "index_group_memberships_on_group_type_and_group_id", using: :btree
  add_index "group_memberships", ["member_type", "member_id"], name: "index_group_memberships_on_member_type_and_member_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string "type"
    t.string "name",    null: false
    t.string "slug"
    t.jsonb  "details"
  end

  add_index "groups", ["details"], name: "index_groups_on_details", using: :gin
  add_index "groups", ["name"], name: "index_groups_on_name", using: :btree
  add_index "groups", ["slug"], name: "index_groups_on_slug", using: :btree

  create_table "houses", force: :cascade do |t|
    t.integer  "publisher_id",                             null: false
    t.string   "publisher_type",                           null: false
    t.integer  "price_sens",     limit: 8, default: 0,     null: false
    t.string   "price_currency",           default: "IDR", null: false
    t.string   "ticker"
    t.string   "state"
    t.string   "address",                                  null: false
    t.float    "longitude"
    t.float    "latitude"
    t.string   "city"
    t.jsonb    "details",                  default: {}
    t.text     "description"
    t.string   "avatar"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "houses", ["city"], name: "index_houses_on_city", using: :btree
  add_index "houses", ["deleted_at"], name: "index_houses_on_deleted_at", using: :btree
  add_index "houses", ["publisher_type", "publisher_id"], name: "index_houses_on_publisher_type_and_publisher_id", using: :btree
  add_index "houses", ["slug"], name: "index_houses_on_slug", using: :btree
  add_index "houses", ["state"], name: "index_houses_on_state", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id", "provider", "uid"], name: "index_identities_on_user_id_and_provider_and_uid", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "occupancies", force: :cascade do |t|
    t.integer  "house_id",                                         null: false
    t.integer  "holder_id"
    t.string   "holder_type"
    t.string   "slug"
    t.string   "ticker"
    t.boolean  "rental",                                           null: false
    t.date     "started_at",                                       null: false
    t.integer  "annual_rental_sens",     limit: 8, default: 0,     null: false
    t.string   "annual_rental_currency",           default: "IDR", null: false
    t.boolean  "tradeable"
    t.jsonb    "details"
    t.datetime "deleted_at"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "occupancies", ["deleted_at"], name: "index_occupancies_on_deleted_at", using: :btree
  add_index "occupancies", ["holder_type", "holder_id"], name: "index_occupancies_on_holder_type_and_holder_id", using: :btree
  add_index "occupancies", ["house_id"], name: "index_occupancies_on_house_id", using: :btree
  add_index "occupancies", ["slug"], name: "index_occupancies_on_slug", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",                        null: false
    t.text     "content_md",                   null: false
    t.text     "content_html",                 null: false
    t.boolean  "draft",        default: false
    t.integer  "user_id",                      null: false
    t.string   "slug"
    t.string   "header"
    t.jsonb    "keywords",     default: {},    null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "posts", ["keywords"], name: "index_posts_on_keywords", using: :gin
  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "house_id",                                 null: false
    t.integer  "holder_id",                                null: false
    t.string   "holder_type",                              null: false
    t.string   "category",                                 null: false
    t.string   "slug"
    t.string   "ticker"
    t.boolean  "tradeable",                                null: false
    t.integer  "price_sens",     limit: 8, default: 0,     null: false
    t.string   "price_currency",           default: "IDR", null: false
    t.integer  "volume",                                   null: false
    t.jsonb    "details"
    t.datetime "deleted_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "stocks", ["category"], name: "index_stocks_on_category", using: :btree
  add_index "stocks", ["deleted_at"], name: "index_stocks_on_deleted_at", using: :btree
  add_index "stocks", ["holder_type", "holder_id"], name: "index_stocks_on_holder_type_and_holder_id", using: :btree
  add_index "stocks", ["house_id"], name: "index_stocks_on_house_id", using: :btree
  add_index "stocks", ["slug"], name: "index_stocks_on_slug", using: :btree
  add_index "stocks", ["tradeable"], name: "index_stocks_on_tradeable", using: :btree

  create_table "subscribers", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "name"
    t.string   "category",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscribers", ["category"], name: "index_subscribers_on_category", using: :btree
  add_index "subscribers", ["email"], name: "index_subscribers_on_email", using: :btree

  create_table "tender_transitions", force: :cascade do |t|
    t.string   "to_state",                   null: false
    t.text     "metadata",    default: "{}"
    t.integer  "sort_key",                   null: false
    t.integer  "tender_id",                  null: false
    t.boolean  "most_recent",                null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "tender_transitions", ["tender_id", "most_recent"], name: "index_tender_transitions_parent_most_recent", unique: true, where: "most_recent", using: :btree
  add_index "tender_transitions", ["tender_id", "sort_key"], name: "index_tender_transitions_parent_sort", unique: true, using: :btree

  create_table "tenders", force: :cascade do |t|
    t.integer  "starter_id",                                null: false
    t.string   "starter_type",                              null: false
    t.integer  "tenderable_id",                             null: false
    t.string   "tenderable_type",                           null: false
    t.string   "category",                                  null: false
    t.string   "aqad",                                      null: false
    t.string   "ticker"
    t.string   "slug",                                      null: false
    t.integer  "annum",                                     null: false
    t.integer  "volume",                                    null: false
    t.integer  "price_sens",      limit: 8, default: 0,     null: false
    t.string   "price_currency",            default: "IDR", null: false
    t.jsonb    "details",                   default: {},    null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "tenders", ["deleted_at"], name: "index_tenders_on_deleted_at", using: :btree
  add_index "tenders", ["details"], name: "index_tenders_on_details", using: :gin
  add_index "tenders", ["slug"], name: "index_tenders_on_slug", using: :btree
  add_index "tenders", ["starter_type", "starter_id"], name: "index_tenders_on_starter_type_and_starter_id", using: :btree
  add_index "tenders", ["tenderable_type", "tenderable_id"], name: "index_tenders_on_tenderable_type_and_tenderable_id", using: :btree
  add_index "tenders", ["ticker"], name: "index_tenders_on_ticker", using: :btree

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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name",                                   null: false
    t.datetime "deleted_at"
    t.string   "avatar"
    t.jsonb    "profile",                default: {}
    t.jsonb    "preferences",            default: {},    null: false
    t.string   "auth_token",             default: "",    null: false
    t.string   "slug",                                   null: false
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["profile"], name: "index_users_on_profile", using: :gin
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vanity_conversions", force: :cascade do |t|
    t.integer "vanity_experiment_id"
    t.integer "alternative"
    t.integer "conversions"
  end

  add_index "vanity_conversions", ["vanity_experiment_id", "alternative"], name: "by_experiment_id_and_alternative", using: :btree

  create_table "vanity_experiments", force: :cascade do |t|
    t.string   "experiment_id"
    t.integer  "outcome"
    t.datetime "created_at"
    t.datetime "completed_at"
  end

  add_index "vanity_experiments", ["experiment_id"], name: "index_vanity_experiments_on_experiment_id", using: :btree

  create_table "vanity_metric_values", force: :cascade do |t|
    t.integer "vanity_metric_id"
    t.integer "index"
    t.integer "value"
    t.string  "date"
  end

  add_index "vanity_metric_values", ["vanity_metric_id"], name: "index_vanity_metric_values_on_vanity_metric_id", using: :btree

  create_table "vanity_metrics", force: :cascade do |t|
    t.string   "metric_id"
    t.datetime "updated_at"
  end

  add_index "vanity_metrics", ["metric_id"], name: "index_vanity_metrics_on_metric_id", using: :btree

  create_table "vanity_participants", force: :cascade do |t|
    t.string   "experiment_id"
    t.string   "identity"
    t.integer  "shown"
    t.integer  "seen"
    t.integer  "converted"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "vanity_participants", ["experiment_id", "converted"], name: "by_experiment_id_and_converted", using: :btree
  add_index "vanity_participants", ["experiment_id", "identity"], name: "by_experiment_id_and_identity", using: :btree
  add_index "vanity_participants", ["experiment_id", "seen"], name: "by_experiment_id_and_seen", using: :btree
  add_index "vanity_participants", ["experiment_id", "shown"], name: "by_experiment_id_and_shown", using: :btree
  add_index "vanity_participants", ["experiment_id"], name: "index_vanity_participants_on_experiment_id", using: :btree

  create_table "visits", id: :uuid, force: :cascade do |t|
    t.uuid     "visitor_id"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.integer  "screen_height"
    t.integer  "screen_width"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "postal_code"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at",       null: false
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree

  add_foreign_key "identities", "users"
end
