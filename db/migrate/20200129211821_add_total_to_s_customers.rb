class AddTotalToSCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :s_customers, :total, :decimal
  end
end
