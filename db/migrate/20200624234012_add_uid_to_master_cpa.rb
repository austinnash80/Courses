class AddUidToMasterCpa < ActiveRecord::Migration[5.1]
  def change
    add_column :master_cpas, :uid, :integer
  end
end
