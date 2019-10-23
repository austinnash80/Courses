class CreateMasterLists < ActiveRecord::Migration[5.1]
  def change
    create_table :master_lists do |t|
      t.string :who
      t.string :list
      t.integer :lid
      t.string :lic
      t.string :fname
      t.string :mi
      t.string :lname
      t.string :suf
      t.string :co
      t.string :add2
      t.string :add
      t.string :city
      t.string :state
      t.string :zip
      t.string :no_mail

      t.timestamps
    end
  end
end
