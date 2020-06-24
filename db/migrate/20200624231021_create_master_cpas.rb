class CreateMasterCpas < ActiveRecord::Migration[5.1]
  def change
    create_table :master_cpas do |t|
      t.string :list
      t.string :string
      t.integer :lid
      t.string :lic
      t.string :lic_st
      t.string :fname
      t.string :mi
      t.string :lname
      t.string :suf
      t.string :co
      t.string :add2
      t.string :add
      t.string :city
      t.string :st
      t.string :zip
      t.boolean :membership
      t.boolean :ethics

      t.timestamps
    end
  end
end
