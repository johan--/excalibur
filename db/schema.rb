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

ActiveRecord::Schema.define(version: 20150728103646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.jsonb    "profile",    default: {}, null: false
    t.datetime "deleted_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "businesses", ["deleted_at"], name: "index_businesses_on_deleted_at", using: :btree
  add_index "businesses", ["profile"], name: "index_businesses_on_profile", using: :gin

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

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

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id", "provider", "uid"], name: "index_identities_on_user_id_and_provider_and_uid", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

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

  create_table "rosters", force: :cascade do |t|
    t.integer  "rosterable_id",                     null: false
    t.string   "rosterable_type",                   null: false
    t.integer  "team_id",                           null: false
    t.integer  "role",                              null: false
    t.string   "state",           default: "aktif", null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "rosters", ["deleted_at"], name: "index_rosters_on_deleted_at", using: :btree
  add_index "rosters", ["rosterable_type", "rosterable_id", "team_id"], name: "index_rosters_on_rosterable_type_and_rosterable_id_and_team_id", unique: true, using: :btree
  add_index "rosters", ["rosterable_type", "rosterable_id"], name: "index_rosters_on_rosterable_type_and_rosterable_id", using: :btree
  add_index "rosters", ["team_id"], name: "index_rosters_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.integer  "teamable_id",                null: false
    t.string   "teamable_type",              null: false
    t.string   "category",                   null: false
    t.jsonb    "data",          default: {}, null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "teams", ["category"], name: "index_teams_on_category", using: :btree
  add_index "teams", ["data"], name: "index_teams_on_data", using: :gin
  add_index "teams", ["deleted_at"], name: "index_teams_on_deleted_at", using: :btree
  add_index "teams", ["teamable_type", "teamable_id"], name: "index_teams_on_teamable_type_and_teamable_id", using: :btree

  create_table "tenders", force: :cascade do |t|
    t.integer  "tenderable_id",                                   null: false
    t.string   "tenderable_type",                                 null: false
    t.string   "category",                                        null: false
    t.string   "state",                default: "belum diproses", null: false
    t.integer  "target_cents",         default: 0,                null: false
    t.string   "target_currency",      default: "USD",            null: false
    t.integer  "contributed_cents",    default: 0,                null: false
    t.string   "contributed_currency", default: "USD",            null: false
    t.jsonb    "properties",           default: {},               null: false
    t.jsonb    "details",              default: {},               null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "tenders", ["category"], name: "index_tenders_on_category", using: :btree
  add_index "tenders", ["details"], name: "index_tenders_on_details", using: :gin
  add_index "tenders", ["properties"], name: "index_tenders_on_properties", using: :gin
  add_index "tenders", ["state"], name: "index_tenders_on_state", using: :btree
  add_index "tenders", ["tenderable_type", "tenderable_id"], name: "index_tenders_on_tenderable_type_and_tenderable_id", using: :btree

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
    t.string   "auth_token",             default: ""
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["profile"], name: "index_users_on_profile", using: :gin
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "identities", "users"
end
