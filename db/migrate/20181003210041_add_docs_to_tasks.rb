class AddDocsToTasks < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :tasks, :task_doc_1
    add_attachment :tasks, :task_doc_2
  end

  def self.down
    remove_attachment :tasks, :task_doc_1
    remove_attachment :tasks, :task_doc_2
  end
end
