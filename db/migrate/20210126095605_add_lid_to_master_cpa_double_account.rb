class AddLidToMasterCpaDoubleAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :master_cpa_double_accounts, :lid, :string
    add_column :master_cpa_double_accounts, :integer, :string
  end
end
