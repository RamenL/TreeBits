class CreateBitModules < ActiveRecord::Migration[5.0]
  def change
    create_table :bit_modules do |t|
      t.string :name
      t.string :author
      t.string :last_modified
      t.string :added_date
      t.string :bit_content
      t.integer :sub_topic_one
      t.integer :sub_topic_two

      t.timestamps
    end
  end
end
