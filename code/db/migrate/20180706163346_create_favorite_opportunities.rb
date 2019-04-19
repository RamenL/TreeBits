class CreateFavoriteOpportunities < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_opportunities, primary_key: ["opportunity_id","email"],force: :cascade do |t|
      t.integer :opportunity_id
      t.integer :user_id
      t.string  :email,                 limit: 50,  null: false

      t.timestamps
    end

     add_foreign_key "favorite_opportunities", "users", column: "email", primary_key: "email", name: "favorite_opportunities_email_fkey", on_update: :cascade, on_delete: :cascade
     add_foreign_key "favorite_opportunities", "opportunity", column: "opportunity_id", primary_key: "opportunity_id", name: "opportunity_id_fkey", on_update: :cascade, on_delete: :cascade

  end
end
