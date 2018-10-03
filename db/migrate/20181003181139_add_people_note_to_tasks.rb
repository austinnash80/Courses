class AddPeopleNoteToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :user_1, :string
    add_column :tasks, :user_2, :string
    add_column :tasks, :user_3, :string
    add_column :tasks, :user_4, :string
    add_column :tasks, :user_5, :string
    add_column :tasks, :user_6, :string
    add_column :tasks, :user_7, :string
    add_column :tasks, :additional_note_2, :text
    add_column :tasks, :additional_note_3, :text
    add_column :tasks, :no_due_date, :boolean
  end
end
