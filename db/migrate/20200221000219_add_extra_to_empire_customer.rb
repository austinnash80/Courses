class AddExtraToEmpireCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_customers, :extra_s1, :string
    add_column :empire_customers, :extra_s2, :string
    add_column :empire_customers, :extra_i, :integer
    add_column :empire_customers, :extra_b, :boolean
  end
end
