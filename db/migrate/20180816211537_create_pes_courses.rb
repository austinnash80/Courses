class CreatePesCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :pes_courses do |t|
      t.integer :pes_number
      t.string :category
      t.integer :hours
      t.boolean :active

      t.timestamps
    end
  end
end
