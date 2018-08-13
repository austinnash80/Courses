class CreateSeqCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :seq_customers do |t|
      t.integer :order_id
      t.integer :uid
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
      t.integer :price_2
      t.string :lic_num

      t.timestamps
    end
  end
end
