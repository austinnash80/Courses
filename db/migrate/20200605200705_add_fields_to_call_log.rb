class AddFieldsToCallLog < ActiveRecord::Migration[5.1]
  def change
    add_column :call_logs, :select_topic, :boolean
    add_column :call_logs, :new_topic, :string
  end
end
