class CreateMasterCpaDoubleAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :master_cpa_double_accounts do |t|
      t.integer :uid
      t.string :lname
      t.string :string
      t.integer :uid
      t.date :search_date

      t.timestamps
    end
  end
end
