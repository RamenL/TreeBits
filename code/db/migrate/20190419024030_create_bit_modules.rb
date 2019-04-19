class CreateBitModules < ActiveRecord::Migration[5.0]
  def change
    create_table :bit_modules do |t|
      t.string :date_added
      t.string :last_modified
      t.string :author
      t.integer :sub_topic_one
      t.integer :sub_topic_two
      t.integer :sub_topic_three
      t.integer :sub_topic_four
      t.integer :sub_topic_five

      t.timestamps
    end
  end
end
