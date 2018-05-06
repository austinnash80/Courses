class CreateUpdatesheets < ActiveRecord::Migration[5.1]
  def change
    create_table :updatesheets do |t|
      t.integer :pes_number
      t.string :pes_version
      t.date :date_received
      t.boolean :update_course
      t.text :note_approval
      t.boolean :text_complete
      t.boolean :exam_complete
      t.boolean :course_listed
      t.date :date_listed
      t.string :role
      t.string :rolep
      t.string :irs_number
      t.boolean :proofed
      t.text :proofed_note
      t.integer :datasheet_id
      t.integer :seq_number
      t.string :seq_version
      t.string :seq_title
      t.string :extra_string
      t.integer :extra_integer
      t.boolean :extra_boolean

      t.timestamps
    end
  end
end
