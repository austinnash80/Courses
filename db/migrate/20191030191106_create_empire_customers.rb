class CreateEmpireCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :empire_customers do |t|
      t.string :uid
      t.string :license_num
      t.string :existing
      t.string :purchase_date
      t.string :lic_state
      t.string :products
      t.string :order_total
      t.string :fname
      t.string :lname
      t.string :company
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
