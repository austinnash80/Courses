class AddDropdownsToCallLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :call_logs, :question_satisfaction, :integer
    add_column :call_logs, :call_difficulty, :integer
  end
end
