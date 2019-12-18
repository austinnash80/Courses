class AddExpToEmpireMasterList < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_master_lists, :exp_date, :date
  end
end
