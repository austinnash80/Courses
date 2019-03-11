class CreateCourseCreationTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :course_creation_tasks do |t|
      t.integer :empire_course_id
      t.string :templete
      t.string :task
      t.text :task_note_1
      t.text :task_note_2
      t.text :task_note_3
      t.string :assign_1
      t.string :assign_2
      t.string :assign_3
      t.string :extra_s
      t.text :extra_t
      t.integer :extra_i
      t.date :extra_d
      t.boolean :extra_b

      t.timestamps
    end
  end
end
