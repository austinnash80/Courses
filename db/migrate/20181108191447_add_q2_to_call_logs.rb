class AddQ2ToCallLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :call_logs, :question_1_topic_other, :string
    add_column :call_logs, :question_2_topic, :string
    add_column :call_logs, :question_2_topic_other, :string
    add_column :call_logs, :question_1_other, :text
    add_column :call_logs, :question_2_other, :text
  end
end
