class DbInitialization < ActiveRecord::Migration[5.0]
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

 # create_table "event_date", primary_key: ["opportunity_id", "on_date"], force: :cascade do |t|
 #   t.integer "opportunity_id", null: false
 #   t.date    "on_date",        null: false
 #   t.time    "start_time"
 #   t.time    "end_time"
 # end

  create_table "form", primary_key: ["opportunity_id", "link_path"], force: :cascade do |t|
    t.integer "opportunity_id",            null: false
    t.string  "link_path",      limit: 50, null: false
  end

  create_table "opportunity", primary_key: "opportunity_id", id: :integer, force: :cascade do |t|
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

 # create_table "opportunity_category", primary_key: ["opportunity_id", "issue_area"], force: :cascade do |t|
 #   t.integer "opportunity_id",             null: false
 #   t.string  "issue_area",     limit: 100, null: false
 # end

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

 # create_table "organization_category", primary_key: ["email", "issue_area"], force: :cascade do |t|
 #   t.string "email",      limit: 50,  null: false
 #   t.string "issue_area", limit: 100, null: false
 # end

  #create_table "skill", primary_key: ["opportunity_id", "skill"], force: :cascade do |t|
  #  t.integer "opportunity_id",             null: false
  #  t.string  "skill",          limit: 100, null: false
 # end

  create_table "users", primary_key: "email", id: :string, limit: 50, force: :cascade do |t|
    t.string  "password_digest", limit: 60, null: false
    t.integer "user_type",       limit: 2,  null: false
  end

  #create_table "volunteer", primary_key: "email", id: :string, limit: 50, force: :cascade do |t|
  #  t.boolean "verified", null: false
  #end

  #add_foreign_key "event_date", "opportunity", primary_key: "opportunity_id", name: "event_date_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "form", "opportunity", primary_key: "opportunity_id", name: "form_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "opportunity", "organization", column: "email", primary_key: "email", name: "opportunity_email_fkey", on_update: :cascade, on_delete: :cascade
  #add_foreign_key "opportunity_category", "opportunity", primary_key: "opportunity_id", name: "opportunity_category_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "organization", "users", column: "email", primary_key: "email", name: "organization_email_fkey", on_update: :cascade, on_delete: :cascade
  #add_foreign_key "organization_category", "organization", column: "email", primary_key: "email", name: "organization_category_email_fkey", on_update: :cascade, on_delete: :cascade
  #add_foreign_key "skill", "opportunity", primary_key: "opportunity_id", name: "skill_id_fkey", on_update: :cascade, on_delete: :cascade
  #add_foreign_key "volunteer", "users", column: "email", primary_key: "email", name: "volunteer_email_fkey", on_update: :cascade, on_delete: :cascade

#add_foreign_key "favorite_opportunities", "users", column: "email", primary_key: "email", name: "favorite_opportunities_email_fkey", on_update: :cascade, on_delete: :cascade
end
