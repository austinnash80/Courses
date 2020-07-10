class AddLidToMasterCpaMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :master_cpa_matches, :lid, :integer
  end
end
