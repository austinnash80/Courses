class AddUidToEmpireMasterList < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_master_lists, :uid, :integer
  end
end
