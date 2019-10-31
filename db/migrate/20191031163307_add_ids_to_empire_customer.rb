class AddIdsToEmpireCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_customers, :ids, :integer
  end
end
