class CreateSequoiaCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :sequoia_customers do |t|
      t.integer :unique_id
      t.integer :order_id
      t.integer :uid
      t.date :purchase_date
      t.string :product
      t.string :who
      t.string :type
      t.string :hours
      t.integer :price
      t.string :fname
      t.string :lname
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :state
      t.string :zip
      t.string :email
      t.string :lic_num

      t.timestamps
    end
  end
end
