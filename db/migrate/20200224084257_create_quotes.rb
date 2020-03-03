class CreateQuotes < ActiveRecord::Migration[5.1]
  def change
    create_table :quotes do |t|
      t.string :quote_code
      t.date :checkin
      t.integer :nights
      t.integer :guests
      t.decimal :price
      t.string :extra_s
      t.boolean :extra_b
      t.integer :extra_i
      t.string :message_1
      t.string :message_2

      t.timestamps
    end
  end
end
