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

ActiveRecord::Schema.define(version: 20190513000150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_brands_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_brands_on_reset_password_token", unique: true, using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promo_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "approved"
    t.boolean  "in_escrow",        default: false
    t.boolean  "paid",             default: false
    t.integer  "promo_id"
    t.string   "image"
    t.string   "video_link",       default: ""
    t.string   "audio_link",       default: ""
    t.string   "website_link",     default: ""
    t.text     "caption",          default: ""
    t.string   "hashtags",         default: ""
    t.text     "additional_notes", default: ""
    t.string   "token"
    t.boolean  "cancelled",        default: false
    t.string   "client_email",     default: ""
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "seen",             default: false
    t.boolean  "complete",         default: false
    t.string   "social_platform"
    t.boolean  "shipped",          default: false
  end

  create_table "promos", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id"
    t.integer  "brand_id"
    t.string   "package_price"
    t.text     "package_details", default: ""
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "access_token"
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean  "claimed",                default: false
    t.string   "username"
    t.string   "followed_by"
    t.string   "follows"
    t.integer  "post_count"
    t.string   "stripe_token"
    t.string   "image"
    t.string   "theme_color",            default: "#eef3f5"
    t.string   "background_image"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
