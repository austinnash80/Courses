class CreateDatasheets < ActiveRecord::Migration[5.1]
  def change
    create_table :datasheets do |t|
      t.integer :seq_number
      t.string :seq_version
      t.string :category
      t.string :seq_title
      t.integer :hours
      t.date :pub_date
      t.date :seq_update
      t.date :seq_original_list
      t.boolean :active
      t.date :drop_date
      t.text :drop_reason
      t.integer :pes_number
      t.string :pes_version
      t.boolean :pes_listed
      t.boolean :needs_approval
      t.boolean :has_approval
      t.text :approval_info
      t.text :course_note
      t.text :extra_note
      t.boolean :extra_boolean
      t.integer :extra_integer

      t.timestamps
    end
  end
end
