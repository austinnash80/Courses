class AddExtraDToUpdatesheet < ActiveRecord::Migration[5.1]
  def change
    add_column :updatesheets, :extra_d, :date
  end
end
