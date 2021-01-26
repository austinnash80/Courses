class AddListToMasterCpaDoubleAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :master_cpa_double_accounts, :list, :string
  end
end
