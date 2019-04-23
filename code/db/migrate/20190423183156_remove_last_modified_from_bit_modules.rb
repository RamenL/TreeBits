class RemoveLastModifiedFromBitModules < ActiveRecord::Migration[5.0]
  def change
    remove_column :bit_modules, :last_modified, :string
  end
end
