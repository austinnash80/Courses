class AddUpdateDatasheetToUpdatesheet < ActiveRecord::Migration[5.1]
  def change
    add_column :updatesheets, :update_datasheet, :boolean
  end
end
