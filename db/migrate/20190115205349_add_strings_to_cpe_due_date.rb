class AddStringsToCpeDueDate < ActiveRecord::Migration[5.1]
  def change
    add_column :cpe_due_dates, :st, :string
    add_column :cpe_due_dates, :state_note, :text
  end
end
