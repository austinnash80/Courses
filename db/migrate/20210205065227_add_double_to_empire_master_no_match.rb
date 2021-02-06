class AddDoubleToEmpireMasterNoMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_master_no_matches, :double, :boolean
  end
end
