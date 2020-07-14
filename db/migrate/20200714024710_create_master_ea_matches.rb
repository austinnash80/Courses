class CreateMasterEaMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :master_ea_matches do |t|
      t.integer :uid
      t.string :lname
      t.integer :lid
      t.string :list

      t.timestamps
    end
  end
end
