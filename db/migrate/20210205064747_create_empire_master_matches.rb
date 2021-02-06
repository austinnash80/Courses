class CreateEmpireMasterMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :empire_master_matches do |t|
      t.integer :uid
      t.string :last_name
      t.string :list
      t.integer :lid
      t.date :search_date

      t.timestamps
    end
  end
end
