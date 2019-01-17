class CreateLiveChatAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :live_chat_answers do |t|
      t.string :company
      t.string :state
      t.string :des
      t.string :question
      t.string :topic
      t.text :answer
      t.text :notes
      t.date :date_org
      t.integer :extra_i
      t.integer :extra_s
      t.date :extra_d

      t.timestamps
    end
  end
end
