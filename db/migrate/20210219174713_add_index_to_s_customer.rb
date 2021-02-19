class AddIndexToSCustomer < ActiveRecord::Migration[5.1]
  def change
    add_index :s_customers, [:order_id], unique: true
  end
end
