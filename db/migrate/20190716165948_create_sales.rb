class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.date :day
      t.decimal :sequoia
      t.decimal :empire
      t.decimal :pacific
      t.decimal :extra_d
      t.string :extra_s
      t.boolean :extra_b

      t.timestamps
    end
  end
end
