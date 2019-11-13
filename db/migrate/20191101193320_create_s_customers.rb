class CreateSCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :s_customers do |t|
      t.integer :s_id
      t.string :order_id
      t.string :uid
      t.string :existing
      t.string :purchase_s
      t.date :purchase
      t.string :product_1
      t.string :product_2
      t.string :designation
      t.string :fname
      t.string :lname
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :price_s
      t.integer :price
      t.string :lic_num
      t.string :lic_state

      t.timestamps
    end
  end
end
