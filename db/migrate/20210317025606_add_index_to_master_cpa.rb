class AddIndexToMasterCpa < ActiveRecord::Migration[5.1]
  def change
    add_index :master_cpas, [:lid], unique: true
  end
end
