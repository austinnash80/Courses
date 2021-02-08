class AddUid2ToMasterEaDoubleAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :master_ea_double_accounts, :uid2, :integer
  end
end
