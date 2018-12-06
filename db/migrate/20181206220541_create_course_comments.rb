class CreateCourseComments < ActiveRecord::Migration[5.1]
  def change
    create_table :course_comments do |t|
      t.string :taken
      t.integer :course_number
      t.string :course_version
      t.string :comment_type
      t.string :comment_type_other
      t.text :comment_details
      t.date :comment_date
      t.string :extra_s
      t.integer :extra_i
      t.boolean :extra_b
      t.date :extra_d

      t.timestamps
    end
  end
end
