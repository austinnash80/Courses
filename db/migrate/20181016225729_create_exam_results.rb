class CreateExamResults < ActiveRecord::Migration[5.1]
  def change
    create_table :exam_results do |t|
      t.date :week_s
      t.date :week_e
      t.integer :course_number
      t.string :course_version
      t.string :course_title
      t.string :who
      t.decimal :score_avg
      t.decimal :rating
      t.integer :taken
      t.integer :exta_i
      t.string :extra_s
      t.boolean :extra_b

      t.timestamps
    end
  end
end
