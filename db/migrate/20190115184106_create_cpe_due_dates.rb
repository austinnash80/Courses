class CreateCpeDueDates < ActiveRecord::Migration[5.1]
  def change
    create_table :cpe_due_dates do |t|
      t.string :state
      t.integer :quanity
      t.string :cpe_group
      t.string :renew_type
      t.string :cpe_due
      t.integer :ss_allowed
      t.integer :year_minimum
      t.boolean :exclude
      t.string :extra_s
      t.boolean :extra_b
      t.integer :extra_i
      t.date :extra_d

      t.timestamps
    end
  end
end
