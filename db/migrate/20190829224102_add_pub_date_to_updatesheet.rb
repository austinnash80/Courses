class AddPubDateToUpdatesheet < ActiveRecord::Migration[5.1]
  def change
    add_column :updatesheets, :pub_date, :date
  end
end
