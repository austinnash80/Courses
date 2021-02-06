class CreateEmpireMasterNoMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :empire_master_no_matches do |t|
      t.integer :uid
      t.string :last_name
      t.string :list
      t.date :search_date

      t.timestamps
    end
  end
end
