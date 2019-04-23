class RemoveAddedDateFromBitModules < ActiveRecord::Migration[5.0]
  def change
    remove_column :bit_modules, :added_date, :string
  end
end
