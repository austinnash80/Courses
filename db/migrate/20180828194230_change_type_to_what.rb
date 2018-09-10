class ChangeTypeToWhat < ActiveRecord::Migration[5.1]
  def change
    rename_column :sequoia_customers, :type, :what
  end
end
