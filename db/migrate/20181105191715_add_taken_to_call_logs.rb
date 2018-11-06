class AddTakenToCallLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :call_logs, :taken, :string
    add_column :call_logs, :call_date, :date
    add_column :call_logs, :note, :text
  end
end
