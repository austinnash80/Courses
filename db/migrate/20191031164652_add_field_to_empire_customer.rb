class AddFieldToEmpireCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_customers, :e_id, :integer
  end
end
