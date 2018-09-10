class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :note
      t.boolean :due
      t.date :due_date
      t.boolean :done
      t.boolean :important
      t.boolean :type_one
      t.boolean :type_two
      t.boolean :type_three
      t.boolean :extra_boolean
      t.string :extra_string
      t.integer :extra_integer
      t.integer :user_id
      # t.attachment :doc

      t.timestamps
    end
  end
end
