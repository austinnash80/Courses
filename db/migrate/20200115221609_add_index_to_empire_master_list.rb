class AddIndexToEmpireMasterList < ActiveRecord::Migration[5.1]
  def change
    add_index :empire_master_lists, [:lid, :list], unique: true
  end
end
