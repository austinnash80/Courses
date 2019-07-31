class AddFieldsToTaskDeadline < ActiveRecord::Migration[5.1]
  def change
    add_column :task_deadlines, :cost, :integer
    add_column :task_deadlines, :time, :integer
  end
end
