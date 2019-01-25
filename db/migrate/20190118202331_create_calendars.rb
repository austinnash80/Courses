class CreateCalendars < ActiveRecord::Migration[5.1]
  def change
    create_table :calendars do |t|
      t.date :event_date
      t.string :title
      t.text :details
      t.string :people
      t.string :creator
      t.string :reoccurring
      t.string :reoccurring_rate
      t.string :tag
      t.date :extra_d
      t.integer :extra_i
      t.string :extra_s

      t.timestamps
    end
  end
end
