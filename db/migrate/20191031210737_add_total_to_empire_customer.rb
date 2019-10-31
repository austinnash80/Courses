class AddTotalToEmpireCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_customers, :total, :decimal
  end
end
