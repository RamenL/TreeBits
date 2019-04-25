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

ActiveRecord::Schema.define(version: 20190425055245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bit_modules", force: :cascade do |t|
    t.string   "name"
    t.string   "author"
    t.string   "bit_content"
    t.integer  "sub_topic_one"
    t.integer  "sub_topic_two"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "super_topic"
  end

  create_table "favorite_opportunities", primary_key: ["opportunity_id", "email"], force: :cascade do |t|
    t.integer  "opportunity_id",            null: false
    t.integer  "user_id"
    t.string   "email",          limit: 50, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "form", primary_key: ["opportunity_id", "link_path"], force: :cascade do |t|
    t.integer "opportunity_id",            null: false
    t.string  "link_path",      limit: 50, null: false
  end

  create_table "opportunity", primary_key: "opportunity_id", id: :integer, default: -> { "nextval('opportunity_id_seq'::regclass)" }, force: :cascade do |t|
    t.string  "name",           limit: 50,  null: false
    t.string  "address",        limit: 100, null: false
    t.string  "city",           limit: 100, null: false
    t.string  "state",          limit: 2,   null: false
    t.string  "zip_code",       limit: 5,   null: false
    t.boolean "transportation",             null: false
    t.string  "description",    limit: 500
    t.string  "frequency",      limit: 50
    t.string  "email",          limit: 50,  null: false
    t.string  "issue_area",     limit: 100
    t.date    "on_date"
    t.time    "start_time"
    t.time    "end_time"
  end

  create_table "organization", primary_key: "email", id: :string, limit: 50, force: :cascade do |t|
    t.string  "name",        limit: 75,  null: false
    t.string  "phone_no",    limit: 12,  null: false
    t.string  "address",     limit: 100
    t.string  "city",        limit: 100
    t.string  "state",       limit: 2
    t.string  "zip_code",    limit: 5
    t.string  "description", limit: 500
    t.boolean "approved",                null: false
    t.string  "issue_area",  limit: 500
  end

  create_table "users", primary_key: "email", id: :string, limit: 50, force: :cascade do |t|
    t.string  "password_digest", limit: 60, null: false
    t.integer "user_type",       limit: 2,  null: false
  end

  add_foreign_key "favorite_opportunities", "opportunity", primary_key: "opportunity_id", name: "opportunity_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "favorite_opportunities", "users", column: "email", primary_key: "email", name: "favorite_opportunities_email_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "form", "opportunity", primary_key: "opportunity_id", name: "form_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "opportunity", "organization", column: "email", primary_key: "email", name: "opportunity_email_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "organization", "users", column: "email", primary_key: "email", name: "organization_email_fkey", on_update: :cascade, on_delete: :cascade
end
