class AddTempToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :course_creation_tasks, :course_creation_templete_id, :integer
  end
end
