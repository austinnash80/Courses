class CreateMasterEaNoMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :master_ea_no_matches do |t|
      t.integer :uid
      t.string :lname
      t.string :list
      t.date :search_date

      t.timestamps
    end
  end
end
