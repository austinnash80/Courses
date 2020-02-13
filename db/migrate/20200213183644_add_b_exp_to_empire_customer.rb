class AddBExpToEmpireCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_customers, :b_exp, :date
    add_column :empire_customers, :b_list, :string
  end
end
