class CreateTxRoyalties < ActiveRecord::Migration[5.1]
  def change
    create_table :tx_royalties do |t|
      t.string :quarter
      t.date :start_date
      t.date :end_date
      t.date :sent_date
      t.integer :sold
      t.decimal :cost
      t.decimal :percentage
      t.boolean :sent
      t.integer :extra_i
      t.boolean :extra_b
      t.string :extra_s

      t.timestamps
    end
  end
end
