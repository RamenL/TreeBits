class AddSuperTopicToBitModules < ActiveRecord::Migration[5.0]
  def change
    add_column :bit_modules, :super_topic, :integer
  end
end
