class AddSourceToEmpireMasterNoMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_master_no_matches, :source, :string
  end
end
