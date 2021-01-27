class CreateMasterEaDoubleAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :master_ea_double_accounts do |t|
      t.integer :uid
      t.string :lname
      t.integer :lid
      t.string :list
      t.date :search_date

      t.timestamps
    end
  end
end
