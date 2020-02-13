class AddEmpireMasterListIdToEmpireCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_customers, :empire_master_list_id, :integer
  end
end
