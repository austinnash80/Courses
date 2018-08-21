class CreateDateFields < ActiveRecord::Migration[5.1]
  def change
    create_table :date_fields do |t|
      t.date :date1
      t.date :date2
      t.date :date3
      t.date :date4

      t.timestamps
    end
  end
end
