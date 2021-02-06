class AddSourceToEmpireMasterMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_master_matches, :source, :string
  end
end
