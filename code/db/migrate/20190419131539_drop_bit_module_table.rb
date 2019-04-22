class DropBitModuleTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :bit_modules
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
