class CreateSequoiaCustomerMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :sequoia_customer_matches do |t|
      t.string :mid
      t.string :uid
      t.date :match_date
      t.string :extra_s
      t.integer :extra_i
      t.boolean :extra_b
      t.date :extra_d

      t.timestamps
    end
  end
end
