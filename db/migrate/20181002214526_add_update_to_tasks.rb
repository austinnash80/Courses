class AddUpdateToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :update_note, :string
  end
end
