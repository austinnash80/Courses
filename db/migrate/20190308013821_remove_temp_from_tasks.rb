class RemoveTempFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :course_creation_tasks, :course_creation_templete_id, :string
  end
end
