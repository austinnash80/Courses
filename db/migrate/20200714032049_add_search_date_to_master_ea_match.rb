class AddSearchDateToMasterEaMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :master_ea_matches, :search_date, :date
  end
end
