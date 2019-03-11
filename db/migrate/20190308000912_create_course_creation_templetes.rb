class CreateCourseCreationTempletes < ActiveRecord::Migration[5.1]
  def change
    create_table :course_creation_templetes do |t|
      t.string :templete_type
      t.text :instruction_1
      t.text :instruction_2
      t.string :extra_s
      t.text :extra_t
      t.integer :extra_i
      t.date :extra_d
      t.boolean :extra_b

      t.timestamps
    end
  end
end
