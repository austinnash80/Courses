class AddPartialToCpeDueDate < ActiveRecord::Migration[5.1]
  def change
    add_column :cpe_due_dates, :partial_mail, :string
    add_column :cpe_due_dates, :partial_number, :decimal
  end
end
