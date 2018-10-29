class CreateSequoiaExams < ActiveRecord::Migration[5.1]
  def change
    create_table :sequoia_exams do |t|
      t.integer :aid
      t.integer :lid
      t.integer :uid
      t.string :who
      t.date :date_s
      t.date :date_c
      t.integer :course_number
      t.string :course_version
      t.string :course_title
      t.integer :score
      t.integer :rate
      t.integer :extra_i
      t.string :extra_s
      t.boolean :extra_b

      t.timestamps
    end
  end
end
