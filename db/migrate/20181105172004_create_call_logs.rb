class CreateCallLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :call_logs do |t|
      t.string :company
      t.string :caller_des
      t.string :caller_state
      t.boolean :customer
      t.string :caller_fname
      t.string :caller_lname
      t.integer :UID
      t.decimal :call_length
      t.string :question_topic
      t.text :question_1
      t.text :question_2
      t.boolean :answered
      t.text :question_answer
      t.integer :question_difficulty
      t.integer :caller_satisfaction
      t.boolean :extra_b
      t.integer :extra_i
      t.string :extra_s

      t.timestamps
    end
  end
end
