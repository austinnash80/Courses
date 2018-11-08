class AddQ2aToCallLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :call_logs, :question_2_answered, :boolean
    add_column :call_logs, :question_2_answer, :text
    add_column :call_logs, :question_additional, :text
    add_column :call_logs, :question_additional_answer, :text
  end
end
