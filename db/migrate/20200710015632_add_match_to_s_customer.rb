class AddMatchToSCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :s_customers, :match, :string
  end
end
