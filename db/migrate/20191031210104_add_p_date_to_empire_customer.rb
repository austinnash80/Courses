class AddPDateToEmpireCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_customers, :p_date, :date
  end
end
