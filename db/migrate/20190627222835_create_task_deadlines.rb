class CreateTaskDeadlines < ActiveRecord::Migration[5.1]
  def change
    create_table :task_deadlines do |t|
      t.string :title
      t.string :state
      t.text :note
      t.string :status
      t.date :date_s
      t.date :date_f
      t.string :extra_s
      t.integer :extra_i
      t.boolean :extra_b
      t.date :extra_d

      t.timestamps
    end
  end
end
