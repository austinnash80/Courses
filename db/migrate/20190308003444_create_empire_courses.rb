class CreateEmpireCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :empire_courses do |t|
      t.integer :number
      t.string :version
      t.string :title
      t.string :category
      t.integer :hours
      t.string :extra_s
      t.integer :extra_i
      t.date :extra_d
      t.boolean :extra_b

      t.timestamps
    end
  end
end
