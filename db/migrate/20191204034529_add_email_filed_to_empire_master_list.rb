class AddEmailFiledToEmpireMasterList < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_master_lists, :email, :string
  end
end
